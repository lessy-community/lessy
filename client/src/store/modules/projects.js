import { mapElementsById } from '../../utils'

import projectsApi from '../../api/projects'

const state = {
  byIds: {},
}

const getters = {
  list (state) {
    return Object.values(state.byIds).sort((p1, p2) => p1.name.localeCompare(p2.name))
  },
}

const actions = {
  create ({ commit }, { name }) {
    return projectsApi.create(name)
                      .then((data) => commit('add', data))
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
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
