import { get, post, patch, put, destroy } from './http'

export default {
  list () {
    return get('/api/users/me/projects?page=1')
  },

  get (id) {
    return get(`/api/projects/${id}`)
  },

  create (name) {
    return post('/api/users/me/projects', { name })
  },

  update (project, payload) {
    return patch(`/api/projects/${project.id}`, payload)
  },

  start (project, dueAt) {
    return put(`/api/projects/${project.id}/state`, {
      project: {
        state: 'started',
        due_at: dueAt,
      },
    })
  },

  finish (project, finishedAt) {
    return put(`/api/projects/${project.id}/state`, {
      project: {
        state: 'finished',
        finished_at: finishedAt,
      },
    })
  },

  pause (project) {
    return put(`/api/projects/${project.id}/state`, {
      project: {
        state: 'paused',
      },
    })
  },

  delete (project) {
    return destroy(`/api/projects/${project.id}`)
  }
}
