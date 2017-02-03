import { get, post } from './http'

export default {
  create (label) {
    return post('/api/tasks', { label })
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
}
