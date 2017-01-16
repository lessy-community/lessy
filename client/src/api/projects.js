import { get, post, patch } from './http'

export default {
  create (name) {
    const payload = {
      project: {
        name,
      },
    }
    return post('/api/projects', payload)
  },

  find (userIdentifier, projectName) {
    return get(`/api/users/${userIdentifier}/projects/${projectName}`)
  },

  update (project, payload) {
    return patch(`/api/projects/${project.id}`, payload)
  },

  start (project, dueAt) {
    const payload = {
      project: {
        dueAt,
      },
    }
    return post(`/api/projects/${project.id}/start`, payload)
  },
}
