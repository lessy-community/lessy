import { get, post } from './http'

function storeAuthenticationToken (data) {
  window.localStorage.setItem('authentication_token', data.token)
  return data
}

export default {
  register: (email) => {
    const payload = {
      user: {
        email,
      },
    }
    return post('/api/users', payload, false).then(storeAuthenticationToken)
  },

  activate: (token, username, password) => {
    const url = `/api/users/${token}/activate`
    const payload = {
      user: {
        username,
        password,
      },
    }
    return post(url, payload, false).then(storeAuthenticationToken)
  },

  login: (username, password) => {
    const payload = {
      username,
      password,
    }
    return post('/api/users/authorize', payload, false).then(storeAuthenticationToken)
  },

  getCurrent: () => {
    return get('/api/users/me')
  },
}
