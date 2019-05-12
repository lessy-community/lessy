import marked from 'marked'

import { groupByFirstCharacter } from '@/utils/array'

import { getWhileNext } from '@/api/http'
import projectsApi from '@/api/projects'

const state = {
  current: null,
  byIds: {},
}

const getters = {
  findById (state, getters, rootState, rootGetters) {
    return id => {
      const project = state.byIds[id]
      if (project == null) {
        return null
      }

      const params = {
        projectSlug: project.slug,
      }
      const isNewed = project.state === 'newed'
      const isStarted = project.state === 'started'
      const isPaused = project.state === 'paused'
      const isFinished = project.state === 'finished'
      return {
        ...project,
        isNewed,
        isStarted,
        isPaused,
        isFinished,
        mdDescription: marked(project.description, { sanitize: true, breaks: true, smartypants: true }),
        startedAt: isStarted ? new Date(project.startedAt * 1000) : null,
        dueAt: isStarted ? new Date(project.dueAt * 1000) : null,
        pausedAt: isPaused ? new Date(project.pausedAt * 1000) : null,
        finishedAt: isFinished ? new Date(project.finishedAt * 1000) : null,
        urlShow: { name: 'project/show', params },
        urlEdit: { name: 'project/edit', params },
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
  },

  listFuture (state, getters) {
    return getters
      .list
      .filter((project) => project.isPaused || project.isNewed)
      .sort((p1, p2) => p1.name.localeCompare(p2.name))
  },

  listFutureByFirstCharacter (state, getters) {
    return groupByFirstCharacter(getters.listFuture, 'slug')
  },

  listInProgress (state, getters) {
    return getters.list
                  .filter((project) => project.isStarted)
                  .sort((p1, p2) => p1.dueAt > p2.dueAt)
  },

  listFinished (state, getters) {
    return getters.list
                  .filter((project) => project.isFinished)
                  .sort((p1, p2) => p1.finishedAt > p2.finishedAt)
  },

  current (state, getters) {
    const projectId = state.current
    if (projectId == null) {
      return null
    }
    return getters.findById(projectId)
  },

  canStartProject (state, getters) {
    const nbStartedProjects = Object.values(state.byIds).reduce((nb, project) => {
      return project.state === 'started' ? nb + 1 : nb
    }, 0)
    return nbStartedProjects < 3
  },
}

const actions = {
  list ({ commit }) {
    return projectsApi.list()
                      .then(getWhileNext((res) => commit('addList', res.data)))
  },

  get ({ commit }, { id }) {
    return projectsApi
      .get(id)
      .then((res) => commit('set', res.data))
  },

  create ({ commit }, { name }) {
    return projectsApi
      .create(name)
      .then((res) => {
        commit('addList', [res.data])
        return res.data.id
      })
  },

  update ({ commit }, { project, ...payload }) {
    return projectsApi.update(project, payload)
                      .then((res) => commit('set', res.data))
  },

  start ({ commit }, { project, dueAt }) {
    return projectsApi
      .start(project, dueAt)
      .then((res) => commit('set', res.data))
      .then((res) => commit('tasks/startTasksForProject', project.id, { root: true }))
  },

  pause ({ commit }, { project }) {
    return projectsApi
      .pause(project)
      .then((res) => commit('set', res.data))
      .then((res) => commit('tasks/cancelTasksForProject', project.id, { root: true }))
  },

  finish ({ commit, state }, { project, finishedAt }) {
    return projectsApi
      .finish(project, finishedAt)
      .then((res) => commit('set', res.data))
  },

  delete ({ commit }, { project }) {
    return projectsApi
      .delete(project)
      .then((res) => {
        commit('remove', project.id)
        commit('tasks/abandonTasksForProject', project.id, { root: true })
      })
  },
}

const mutations = {
  addList (state, data) {
    let byIds = {}
    data.forEach((element) => {
      byIds[element.id] = {
        id: element.id,
        ...element.attributes,
        userId: element.relationships.user.data.id,
      }
    })

    state.byIds = {
      ...state.byIds,
      ...byIds,
    }
  },

  set (state, data) {
    state.byIds = {
      ...state.byIds,
      [data.id]: {
        id: data.id,
        ...data.attributes,
        userId: data.relationships.user.data.id,
      },
    }
  },

  remove (state, id) {
    let byIds = { ...state.byIds }
    delete byIds[id]
    state.byIds = byIds
  },

  setCurrent (state, projectSlug) {
    state.current = Object.keys(state.byIds)
                          .find((id) => state.byIds[id].slug === projectSlug)
  },

  reset (state) {
    state.current = null
    state.byIds = {}
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
