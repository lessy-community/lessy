import { mapElementsById } from '../../utils'

import tasksApi from '../../api/tasks'

const state = {
  byIds: {},
}

const getters = {
  findById (state, getters) {
    return id => {
      const task = state.byIds[id]
      return {
        ...task,
        isFinished: !!task.finishedAt,
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
  },
}

const actions = {
  create ({ commit }, { label }) {
    return tasksApi
      .create(label)
      .then((data) => {
        commit('add', data)
        return data.id
      })
  },

  finish ({ commit }, { task }) {
    return tasksApi.finish(task)
                   .then((data) => commit('set', data))
  },

  restart ({ commit }, { task }) {
    return tasksApi.restart(task)
                   .then((data) => commit('set', data))
  },
}

const mutations = {
  setup (state, tasks) {
    state.byIds = mapElementsById(tasks)
  },

  add (state, task) {
    state.byIds = {
      ...state.byIds,
      [task.id]: task,
    }
  },

  set (state, task) {
    state.byIds = {
      ...state.byIds,
      [task.id]: task,
    }
  },

  reset (state) {
    state.current = null
    state.byIds = {}
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
