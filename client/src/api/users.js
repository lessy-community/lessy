import { get, post } from './http'

export default {
  register: (email) => {
    return post('/api/users', { email }, false)
  },

  resendActivationEmail: (email) => {
    const payload = {
      user: {
        email,
      },
    }
    return post('/api/users/activation_emails', payload, false)
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
    return post(url, payload, false)
  },

  login: (username, password) => {
    const payload = {
      username,
      password,
    }
    return post('/api/users/authorizations', payload, false)
  },

  getCurrent: () => {
    return get('/api/users/me')
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
    return post('/api/users/password_resets', payload, false)
  },

  changePassword: (token, password) => {
    const payload = {
      user: {
        password,
      },
      token,
    }
    return post('/api/users/passwords', payload, false)
  },
}
