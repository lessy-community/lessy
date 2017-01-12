import { post } from './http'

export default {
  create (name) {
    const payload = {
      project: {
        name,
      },
    }
    return post('/api/projects', payload)
  },
}
