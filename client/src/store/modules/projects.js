import { mapElementsById, formatDate } from '../../utils'

import projectsApi from '../../api/projects'

const state = {
  current: null,
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
      return {
        ...project,
        user,
        isStarted,
        isFinished: isStarted && !project.isInProgress,
        startedAtLabel: isStarted ? formatDate(project.startedAt) : '',
        dueAtLabel: isStarted ? formatDate(project.dueAt) : '',
        urlShow: { name: 'project/show', params },
        urlEdit: { name: 'project/edit', params },
        urlStart: { name: 'project/start', params },
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
  },

  listNotInProgress (state, getters) {
    return getters.list
                  .filter((project) => !project.isInProgress)
                  .sort((p1, p2) => p1.name.localeCompare(p2.name))
  },

  listInProgress (state, getters) {
    return getters.list
                  .filter((project) => project.isInProgress)
                  .sort((p1, p2) => p1.dueAt > p2.dueAt)
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
}

const actions = {
  create ({ commit }, { name }) {
    return projectsApi.create(name)
                      .then((data) => commit('add', data))
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
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
