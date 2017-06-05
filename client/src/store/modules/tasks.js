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
      const isAbandoned = !!task.abandonedAt
      const isBacklogged = !isAbandoned && !task.dueAt
      const isFinished = !!task.finishedAt
      const dueAtDate = !isBacklogged && moment.unix(task.dueAt)
      const isPending = !isBacklogged && !isFinished && !isAbandoned && dueAtDate.isBefore(moment().startOf('day'))
      const createdSinceWeeks = moment.utc().diff(moment.unix(task.createdAt), 'weeks')
      return {
        ...task,
        isBacklogged,
        isFinished,
        isAbandoned,
        isPending,
        createdSinceWeeks,
        dueAtLabel: formatDate(task.dueAt),
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
                 .sort((t1, t2) => t1.order - t2.order)
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
  },

  listBacklog (state, getters) {
    return getters
      .list
      .filter((task) => task.isBacklogged)
  },
}

const actions = {
  create ({ commit }, { label, dueAt }) {
    return tasksApi
      .create(label, dueAt)
      .then((data) => {
        commit('add', data)
        return data.id
      })
  },

  update ({ commit }, { task, label }) {
    return tasksApi.update(task, label)
                   .then((data) => commit('set', data))
  },

  finish ({ commit }, { task }) {
    return tasksApi.finish(task)
                   .then((data) => commit('set', data))
  },

  restart ({ commit }, { task }) {
    return tasksApi.restart(task)
                   .then((data) => commit('set', data))
  },

  start ({ commit }, { task }) {
    return tasksApi.start(task)
                   .then((data) => commit('set', data))
  },

  abandon ({ commit }, { task }) {
    return tasksApi.abandon(task)
                   .then((data) => commit('set', data))
  },

  getPending ({ commit }) {
    return tasksApi.getPending()
                   .then((data) => commit('addList', data))
  },

  getBacklog ({ commit }) {
    return tasksApi.getBacklog()
                   .then((data) => commit('addList', data))
  },

  orderAfter ({ commit }, { task, afterTaskId }) {
    return tasksApi.orderAfter(task, afterTaskId)
                   .then((data) => commit('setOrder', data))
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

  setOrder (state, newOrderTasks) {
    const impactedTasks = newOrderTasks.map(orderTask => {
      return {
        ...state.byIds[orderTask.id],
        order: orderTask.order,
      }
    }).filter(task => task.id != null)
    state.byIds = {
      ...state.byIds,
      ...mapElementsById(impactedTasks),
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
