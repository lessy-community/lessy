import rootApi from '@/api/root'

const state = {
  resourcesReady: false,
  registrationDisabled: true,
  tosVersion: null,
}

const getters = {
  registrationDisabled (state) {
    return state.registrationDisabled
  },

  tosVersion (state) {
    return state.tosVersion
  },

  resourcesReady (state) {
    return state.resourcesReady
  },
}

const actions = {
  listInfo ({ commit }, email) {
    return rootApi.listInfo()
      .then((res) => {
        commit('setInfo', res)
      })
  },
}

const mutations = {
  setInfo (state, data) {
    state.registrationDisabled = data.registrationDisabled
    state.tosVersion = data.tosVersion
  },

  setResourcesReady (state, value) {
    state.resourcesReady = value
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
