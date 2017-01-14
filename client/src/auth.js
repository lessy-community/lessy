export default {

  login (token) {
    window.localStorage.setItem('authentication_token', token)
  },

  logout () {
    window.localStorage.removeItem('authentication_token')
  },

  getToken () {
    return window.localStorage.getItem('authentication_token')
  },

  isLoggedIn () {
    return this.getToken() != null
  },

}
