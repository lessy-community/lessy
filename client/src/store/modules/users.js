import usersApi from '../../api/users'

const state = {
  current: null,
}

const actions = {
  register ({ commit }, email) {
    return usersApi.register(email)
                   .then((user) => commit('setCurrentUser', user))
  },

  activate ({ commit }, { token, username, password }) {
    return usersApi.activate(token, username, password)
                   .then((user) => commit('setCurrentUser', user))
  },
}

const mutations = {
  setCurrentUser (state, user) {
    state.current = user
  },
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
}
