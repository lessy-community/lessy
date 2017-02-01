import { post } from './http'

export default {
  create (label) {
    return post('/api/tasks', { label })
  },

  finish (task) {
    return post(`/api/tasks/${task.id}/finish`)
  },
}
