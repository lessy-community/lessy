import { get, post, patch } from './http'

export default {
  list () {
    return get('/api/tasks')
  },

  create (label, dueAt) {
    return post('/api/tasks', { label, dueAt })
  },

  update (task, payload) {
    return patch(`/api/tasks/${task.id}`, payload)
  },

  finish (task) {
    return post(`/api/tasks/${task.id}/finish`)
  },

  restart (task) {
    return post(`/api/tasks/${task.id}/restart`)
  },

  start (task) {
    return post(`/api/tasks/${task.id}/start`)
  },

  abandon (task) {
    return post(`/api/tasks/${task.id}/abandon`)
  },

  orderAfter (task, afterTaskId) {
    return post(`/api/tasks/${task.id}/order_after`, { afterTaskId })
  },
}
