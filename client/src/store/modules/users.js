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

  login ({ commit }, { username, password }) {
    return usersApi.login(username, password)
  },

  getCurrent ({ commit }) {
    return usersApi.getCurrent()
                   .then((user) => commit('setCurrentUser', user))
  },

  logout ({ commit }) {
    window.localStorage.removeItem('authentication_token')
    commit('setCurrentUser', null)
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
