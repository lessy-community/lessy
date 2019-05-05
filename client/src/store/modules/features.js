import api from '@/api/features'

const state = {
  enabled: [],
}

const getters = {
}

const actions = {
  list ({ commit }) {
    return api.list().then((res) => commit('enableList', res.data))
  },
}

const mutations = {
  enableList (state, data) {
    state.enabled = data.map((feature) => feature.id)
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
