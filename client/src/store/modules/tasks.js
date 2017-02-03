import moment from 'moment'

import { mapElementsById, formatDate } from '../../utils'

import tasksApi from '../../api/tasks'

const state = {
  byIds: {},
}

const getters = {
  findById (state, getters) {
    return id => {
      const task = state.byIds[id]
      const isFinished = !!task.finishedAt
      const dueAtDate = moment.unix(task.dueAt)
      const isPending = !isFinished && dueAtDate.isBefore(moment().startOf('day'))
      return {
        ...task,
        isFinished,
        isPending,
        dueAtLabel: formatDate(task.dueAt),
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
  },

  listForToday (state, getters) {
    return getters
      .list
      .filter((task) => {
        const now = moment()
        const dueAtDate = moment.unix(task.dueAt)
        const isToday = dueAtDate.isBetween(now.startOf('day'), now.endOf('day'), 'day', '[]')
        return isToday
      })
  },

  listPending (state, getters) {
    return getters
      .list
      .filter((task) => task.isPending)
      .sort((p1, p2) => p1.dueAt < p2.dueAt)
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

  getPending ({ commit }) {
    return tasksApi.getPending()
                   .then((data) => commit('addList', data))
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

  addList (state, tasks) {
    state.byIds = {
      ...state.byIds,
      ...mapElementsById(tasks),
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
