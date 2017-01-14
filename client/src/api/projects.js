import { get, post } from './http'

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
    return get(`/api/projects/${userIdentifier}/${projectName}`)
  },
}
