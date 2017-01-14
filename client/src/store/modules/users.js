import usersApi from '../../api/users'
import auth from '../../auth'

const state = {
  current: null,
  byIds: {},
}

const getters = {
  findById (state) {
    return id => {
      const user = state.byIds[id]
      return {
        ...user,
        activated: !!user.username,
        displayedName: user.username || user.email,
        identifier: user.username || user.id,
        isLoggedIn: auth.isLoggedIn(),
      }
    }
  },

  current (state, getters) {
    const currentId = state.current
    if (currentId == null) {
      return null
    }
    return getters.findById(state.current)
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
    commit('resetCurrent', true)
  },
}

const mutations = {
  setCurrentUser (state, user) {
    state.byIds = {
      ...state.byIds,
      [user.id]: user,
    }
    state.current = user.id
  },

  resetCurrent (state, hard = false) {
    if (hard) {
      delete state.byIds[state.current]
    }
    state.current = null
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
