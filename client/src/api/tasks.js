import { get, post } from './http'

export default {
  create (label, dueAt) {
    return post('/api/tasks', { label, dueAt })
  },

  finish (task) {
    return post(`/api/tasks/${task.id}/finish`)
  },

  restart (task) {
    return post(`/api/tasks/${task.id}/restart`)
  },

  getPending () {
    return get('/api/tasks/pending')
  },

  getBacklog () {
    return get('/api/tasks/backlog')
  },
}
