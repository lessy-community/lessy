import { get, post } from './http'

import moment from 'moment'

export default {
  create (label) {
    const dueAt = moment().endOf('day').unix()
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
}
