import { get, post, patch } from './http'

export default {
  create (name) {
    return post('/api/projects', { name })
  },

  find (userIdentifier, projectName) {
    return get(`/api/users/${userIdentifier}/projects/${projectName}`)
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

  getFinished (userIdentifier) {
    return get(`/api/users/${userIdentifier}/finished`)
  },
}
