import termsOfServiceApi from 'src/api/terms_of_services'

const state = {
  current: null,
}

const getters = {
  current (state) {
    return state.current
  },
}

const actions = {
  getCurrent ({ commit }) {
    return termsOfServiceApi.getCurrent()
      .then((res) => {
        commit('setCurrent', res.data)
      })
  },
}

const mutations = {
  setCurrent (state, data) {
    state.current = {
      id: data.id,
      ...data.attributes,
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
