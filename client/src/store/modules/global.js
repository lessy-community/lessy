import rootApi from 'src/api/root'

const state = {
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
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
