import { get, post, patch } from './http'

export default {
  create (label, dueAt) {
    return post('/api/tasks', { label, dueAt })
  },

  update (task, label) {
    return patch(`/api/tasks/${task.id}`, { label })
  },

  finish (task) {
    return post(`/api/tasks/${task.id}/finish`)
  },

  restart (task) {
    return post(`/api/tasks/${task.id}/restart`)
  },

  abandon (task) {
    return post(`/api/tasks/${task.id}/abandon`)
  },

  getPending () {
    return get('/api/tasks/pending')
  },

  getBacklog () {
    return get('/api/tasks/backlog')
  },

  orderAfter (task, afterTaskId) {
    return post(`/api/tasks/${task.id}/order_after`, { afterTaskId })
  },
}
