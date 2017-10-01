import { get, post, patch, put } from './http'

export default {
  list () {
    return get('/api/users/me/projects')
  },

  create (name) {
    return post('/api/users/me/projects', { name })
  },

  update (project, payload) {
    return patch(`/api/projects/${project.id}`, payload)
  },

  start (project, dueAt) {
    return put(`/api/projects/${project.id}/state`, {
      state: 'started',
      date: dueAt,
    })
  },

  finish (project, finishedAt) {
    return put(`/api/projects/${project.id}/state`, {
      state: 'finished',
      date: finishedAt,
    })
  },

  stop (project) {
    return put(`/api/projects/${project.id}/state`, {
      state: 'stopped',
    })
  },
}
