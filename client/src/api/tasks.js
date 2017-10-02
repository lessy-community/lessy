import { get, post, patch, put } from './http'

export default {
  list () {
    return get('/api/users/me/tasks')
  },

  create (label, dueAt, projectId) {
    return post('/api/users/me/tasks', { label, dueAt, projectId })
  },

  update (task, label) {
    return patch(`/api/tasks/${task.id}`, { label })
  },

  finish (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'finished',
    })
  },

  start (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'started',
    })
  },

  abandon (task) {
    return put(`/api/tasks/${task.id}/state`, {
      state: 'abandoned',
    })
  },

  orderAfter (task, afterTaskId) {
    return put(`/api/tasks/${task.id}/order`, { afterTaskId })
  },
}
