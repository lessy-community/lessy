import { mapElementsById, formatDate } from '../../utils'

import projectsApi from '../../api/projects'

const state = {
  current: null,
  numberFinished: 0,
  byIds: {},
}

const getters = {
  findById (state, getters, rootState, rootGetters) {
    return id => {
      const project = state.byIds[id]
      const user = rootGetters['users/findById'](project.userId)
      const params = {
        userIdentifier: user.identifier,
        projectName: project.name,
      }
      const isStarted = !!project.startedAt
      const isStopped = !!project.stoppedAt
      const isFinished = !!project.finishedAt
      return {
        ...project,
        user,
        isStarted,
        isStopped,
        isFinished,
        startedAtLabel: isStarted ? formatDate(project.startedAt) : '',
        dueAtLabel: isStarted ? formatDate(project.dueAt) : '',
        stoppedAtLabel: isStopped ? formatDate(project.stoppedAt) : '',
        finishedAtLabel: isFinished ? formatDate(project.finishedAt) : '',
        urlShow: { name: 'project/show', params },
        urlEdit: { name: 'project/edit', params },
        urlStart: { name: 'project/start', params },
        urlFinish: { name: 'project/finish', params },
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
  },

  listNotStarted (state, getters) {
    return getters
      .list
      .filter((project) => !project.isStarted)
      .sort((p1, p2) => {
        if (p1.isStopped === p2.isStopped) {
          return p1.name.localeCompare(p2.name)
        }
        return p1.isStopped < p2.isStopped
      })
  },

  listInProgress (state, getters) {
    return getters.list
                  .filter((project) => project.isInProgress)
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
      return project.isInProgress ? nb + 1 : nb
    }, 0)
    return nbStartedProjects < 3
  },

  numberCurrent (state, getters) {
    return Object.keys(state.byIds)
      .map(getters.findById)
      .filter((project) => !project.isFinished)
      .length
  },
}

const actions = {
  create ({ commit }, { name }) {
    return projectsApi
      .create(name)
      .then((data) => {
        commit('add', data)
        return data.id
      })
  },

  find ({ commit }, { userIdentifier, projectName }) {
    return projectsApi.find(userIdentifier, projectName)
                      .then((data) => commit('setCurrent', data))
  },

  update ({ commit }, { project, ...payload }) {
    return projectsApi.update(project, payload)
                      .then((data) => commit('set', data))
  },

  start ({ commit }, { project, dueAt }) {
    return projectsApi.start(project, dueAt)
                      .then((data) => commit('set', data))
  },

  stop ({ commit }, { project }) {
    return projectsApi.stop(project)
                      .then((data) => commit('set', data))
  },

  finish ({ commit, state }, { project, finishedAt }) {
    return projectsApi
      .finish(project, finishedAt)
      .then((data) => {
        commit('set', data)
        commit('setNumberFinished', state.numberFinished + 1)
      })
  },

  getFinished ({ commit }, { userIdentifier }) {
    return projectsApi
      .getFinished(userIdentifier)
      .then((data) => {
        commit('addList', data)
      })
  },
}

const mutations = {
  setup (state, projects) {
    state.byIds = mapElementsById(projects)
  },

  add (state, project) {
    state.byIds = {
      ...state.byIds,
      [project.id]: project,
    }
  },

  addList (state, projects) {
    state.byIds = {
      ...state.byIds,
      ...mapElementsById(projects),
    }
  },

  set (state, project) {
    state.byIds = {
      ...state.byIds,
      [project.id]: project,
    }
  },

  setCurrent (state, project) {
    state.byIds = {
      ...state.byIds,
      [project.id]: project,
    }
    state.current = project.id
  },

  resetCurrent (state, hard = false) {
    if (hard) {
      delete state.byIds[state.current]
    }
    state.current = null
  },

  setNumberFinished (state, numberFinished) {
    state.numberFinished = numberFinished
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
