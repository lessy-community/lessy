import { get, post, patch, destroy } from './http'

export default {
  register: (email) => {
    return post('/api/users', { email }, { authorization: 'none' })
  },

  resendActivationEmail: (email) => {
    const payload = {
      user: {
        email,
      },
    }
    return post('/api/users/activation_emails', payload, { authorization: 'none' })
  },

  activate: (token, username, password) => {
    const url = `/api/users/activations`
    const payload = {
      user: {
        username,
        password,
      },
      token,
    }
    return post(url, payload, { authorization: 'none' })
  },

  login: (username, password) => {
    const payload = {
      username,
      password,
    }
    return post('/api/users/authorizations', payload, { authorization: 'none' })
  },

  sudo: (username, password) => {
    const payload = {
      username,
      password,
      sudo: true,
    }
    return post('/api/users/authorizations', payload, { authorization: 'none' })
  },

  getCurrent: () => {
    return get('/api/users/me')
  },

  updateCurrent: (username, email) => {
    const payload = {
      user: {
        username,
        email,
      },
    }
    return patch('/api/users/me', payload)
  },

  acceptTermsOfService: () => {
    return post('/api/users/me/terms_of_services', {})
  },

  resetPassword: (email) => {
    const payload = {
      user: {
        email,
      },
    }
    return post('/api/users/password_resets', payload, { authorization: 'none' })
  },

  changePassword: (password, token = null) => {
    const payload = {
      user: {
        password,
      },
      token,
    }
    const authorization = token == null ? 'sudo' : 'none'
    return post('/api/users/passwords', payload, { authorization })
  },

  deleteAccount: (userActive) => {
    const authorization = userActive ? 'sudo' : 'normal'
    return destroy('/api/users/me', {}, { authorization })
  },
}
