import usersApi from '../../api/users'
import auth from '../../auth'

const state = {
  current: null,
}

const getters = {
  current (state) {
    const user = state.current
    if (user == null) {
      return null
    }
    return {
      ...user,
      activated: !!user.username,
      displayedName: user.username || user.email,
      identifier: user.username || user.id,
      isLoggedIn: auth.isLoggedIn(),
    }
  },
}

const actions = {
  register ({ commit }, email) {
    return usersApi.register(email)
                   .then((data) => commit('setCurrentUser', data.user))
  },

  activate ({ commit }, { token, username, password }) {
    return usersApi.activate(token, username, password)
                   .then((data) => commit('setCurrentUser', data.user))
  },

  login ({ commit }, { username, password }) {
    return usersApi.login(username, password)
  },

  getCurrent ({ commit }) {
    return usersApi.getCurrent()
      .then((data) => {
        commit('setCurrentUser', data.user)
        commit('projects/setup', data.projects, { root: true })
      })
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
  getters,
  actions,
  mutations,
}
