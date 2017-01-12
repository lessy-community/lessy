import projectsApi from '../../api/projects'

const state = {
  byIds: {},
}

const actions = {
  create ({ commit }, { name }) {
    return projectsApi.create(name)
                      .then((data) => commit('add', data))
  },
}

const mutations = {
  add (state, project) {
    state.byIds[project.id] = project
  },
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
}
