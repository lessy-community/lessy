import { get, post, patch } from './http'

export default {
  list () {
    return get('/api/projects')
  },

  create (name) {
    return post('/api/projects', { name })
  },

  update (project, payload) {
    return patch(`/api/projects/${project.id}`, payload)
  },

  start (project, dueAt) {
    return post(`/api/projects/${project.id}/start`, { dueAt })
  },

  finish (project, finishedAt) {
    return post(`/api/projects/${project.id}/finish`, { finishedAt })
  },

  stop (project) {
    return post(`/api/projects/${project.id}/stop`)
  },
}
