export default {
  login (token) {
    window.localStorage.setItem('authentication_token', token)
  },

  isLoggedIn () {
    return this.getToken('normal') != null
  },

  sudo (token) {
    window.localStorage.setItem('sudo_token', token)
  },

  isSudo () {
    return this.getToken('sudo') != null
  },

  logout () {
    window.localStorage.removeItem('authentication_token')
    window.localStorage.removeItem('sudo_token')
  },

  getToken (mode = 'normal') {
    const itemName = mode === 'normal' ? 'authentication_token' : 'sudo_token'
    return window.localStorage.getItem(itemName)
  },
}
