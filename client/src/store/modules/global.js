import rootApi from 'src/api/root'

const state = {
  registrationDisabled: true,
}

const getters = {
  registrationDisabled (state) {
    return state.registrationDisabled
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
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
