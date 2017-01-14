import { mapElementsById } from '../../utils'

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
      return {
        ...project,
        urlShow: { name: 'project/show', params },
        urlEdit: { name: 'project/edit', params },
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
                 .sort((p1, p2) => p1.name.localeCompare(p2.name))
  },

  current (state, getters) {
    const projectId = state.current
    if (projectId == null) {
      return null
    }
    return getters.findById(projectId)
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
