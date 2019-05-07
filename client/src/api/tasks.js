import { get, post, patch, put } from './http'

export default {
  list () {
    return get('/api/users/me/tasks?page=1')
  },

  get (id) {
    return get(`/api/tasks/${id}`)
  },

  create (label, plannedAt, projectId) {
    return post('/api/users/me/tasks', { label, plannedAt, projectId })
  },

  update (task, payload) {
    return patch(`/api/tasks/${task.id}`, payload)
  },

  finish (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'finished',
    })
  },

  start (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'planned',
    })
  },

  unplan (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'started',
    })
  },

  abandon (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'abandoned',
    })
  },

  updateOrder (task, order) {
    const payload = {
      task: {
        order,
      },
    }
    return put(`/api/tasks/${task.id}/order`, payload)
  },
}
