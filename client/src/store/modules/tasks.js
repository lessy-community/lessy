import moment from 'moment'
import sanitizeHtml from 'sanitize-html'
import anchorme from 'anchorme'

import { getWhileNext } from '../../api/http'

import { mapElementsById, formatDate } from '../../utils'

import tasksApi from '../../api/tasks'

const state = {
  byIds: {},
}

const getters = {
  findById (state, getters) {
    return id => {
      const task = state.byIds[id]
      if (task == null) {
        return null
      }

      const today = moment()
      const plannedAtDate = moment.unix(task.plannedAt)

      const isFinished = !!task.finishedAt
      const isAbandoned = !!task.abandonedAt

      const isForToday = !isAbandoned && plannedAtDate.isBetween(today.startOf('day'), today.endOf('day'), 'day', '[]')
      const isBacklogged = !isFinished && !isAbandoned && !isForToday
      const startedSinceWeeks = task.startedAt > 0 ? moment.utc().diff(moment.unix(task.startedAt), 'weeks') : 0

      const allowedTags = ['b', 'i', 'em', 'strong']
      const anchorOptions = {
        files: false,
        attributes: [
          { name: 'target', value: '_blank' },
          { name: 'rel', value: 'noreferrer' },
        ]
      }

      return {
        ...task,
        isForToday,
        isBacklogged,
        isFinished,
        isAbandoned,
        startedSinceWeeks,
        restartedCount: task.plannedCount - 1,
        plannedAtLabel: formatDate(task.plannedAt),
        formattedLabel: anchorme(sanitizeHtml(task.label, { allowedTags }), anchorOptions),
      }
    }
  },

  list (state, getters) {
    return Object.keys(state.byIds)
                 .map(getters.findById)
                 .filter((task) => !task.isAbandoned)
                 .sort((t1, t2) => t1.order - t2.order)
  },

  listForToday (state, getters) {
    return getters
      .list
      .filter((task) => task.isForToday)
  },

  listBacklog (state, getters) {
    return getters
      .list
      .filter((task) => task.isBacklogged && task.state !== 'newed')
  },

  listFinished (state, getters) {
    return getters.list.filter((task) => task.isFinished)
  },

  listForProject (state, getters, rootState, rootGetters) {
    return project => {
      return getters.list.filter((task) => task.projectId === project.id)
    }
  },

  listForCurrentProject (state, getters, rootState, rootGetters) {
    const currentProject = rootGetters['projects/current']
    return getters.listForProject(currentProject)
  },

  countFinishedByDays (state, getters) {
    const byDays = {}
    getters.listFinished.forEach((task) => {
      const finishedAt = moment.unix(task.finishedAt)
      const key = finishedAt.format('YYYY-MM-DD')
      byDays[key] = (byDays[key] || 0) + 1
    })
    return byDays
  },

  countCreatedByDays (state, getters) {
    const byDays = {}
    getters.list.forEach((task) => {
      const startedAt = moment.unix(task.startedAt)
      const key = startedAt.format('YYYY-MM-DD')
      byDays[key] = (byDays[key] || 0) + 1
    })
    return byDays
  },
}

const actions = {
  list ({ commit }) {
    return tasksApi.list()
                   .then(getWhileNext((res) => commit('addList', res.data)))
  },

  create ({ commit }, { label, plannedAt }) {
    return tasksApi
      .create(label, plannedAt)
      .then((res) => {
        commit('addList', [res.data])
        return res.data.id
      })
  },

  createForProject ({ commit }, { label, plannedAt, projectId }) {
    return tasksApi
      .create(label, plannedAt, projectId)
      .then((res) => {
        commit('addList', [res.data])
        return res.data.id
      })
  },

  update ({ commit }, { task, ...payload }) {
    return tasksApi.update(task, payload)
                   .then((res) => commit('set', res.data))
  },

  finish ({ commit }, { task }) {
    return tasksApi.finish(task)
                   .then((res) => commit('set', res.data))
  },

  restart ({ commit }, { task }) {
    return tasksApi.restart(task)
                   .then((res) => commit('set', res.data))
  },

  start ({ commit }, { task }) {
    return tasksApi.start(task)
                   .then((res) => commit('set', res.data))
  },

  abandon ({ commit }, { task }) {
    return tasksApi.abandon(task)
                   .then((res) => commit('set', res.data))
  },

  updateOrder ({ commit }, { task, order }) {
    return tasksApi.updateOrder(task, order)
                   .then((res) => commit('setOrder', res.data))
  },
}

const mutations = {
  addList (state, data) {
    let byIds = {}
    data.forEach((element) => {
      byIds[element.id] = {
        id: element.id,
        ...element.attributes,
        userId: element.relationships.user.data.id,
      }
      if (element.relationships.project.data != null) {
        byIds[element.id].projectId = element.relationships.project.data.id
      }
    })

    state.byIds = {
      ...state.byIds,
      ...byIds,
    }
  },

  set (state, data) {
    let byIds = {
      ...state.byIds,
      [data.id]: {
        id: data.id,
        ...data.attributes,
        userId: data.relationships.user.data.id,
      },
    }
    if (data.relationships.project.data != null) {
      byIds[data.id].projectId = data.relationships.project.data.id
    }
    state.byIds = byIds
  },

  setOrder (state, data) {
    const impactedTasks = data.map(task => {
      return {
        ...state.byIds[task.id],
        order: task.attributes.order,
      }
    }).filter(task => task.id != null)
    state.byIds = {
      ...state.byIds,
      ...mapElementsById(impactedTasks),
    }
  },

  startTasksForProject (state, projectId) {
    const tasks = Object.entries(state.byIds).map(([id, task]) => {
      if (task.projectId !== projectId || task.state !== 'newed') {
        return task
      }
      return {
        ...task,
        state: 'started',
        startedAt: +moment(),
      }
    })
    state.byIds = mapElementsById(tasks)
  },

  cancelTasksForProject (state, projectId) {
    const tasks = Object.entries(state.byIds).map(([id, task]) => {
      if (task.projectId !== projectId || task.state !== 'started') {
        return task
      }
      return {
        ...task,
        state: 'newed',
        startedAt: null,
      }
    })
    state.byIds = mapElementsById(tasks)
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
