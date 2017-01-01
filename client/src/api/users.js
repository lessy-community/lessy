import { post } from './http'

export default {
  register: (email) => {
    const payload = {
      user: {
        email,
      },
    }
    return post('/api/users', payload)
  },

  activate: (token, username, password) => {
    const url = `/api/users/${token}/activate`
    const payload = {
      user: {
        username,
        password,
      },
    }
    return post(url, payload)
  },
}
