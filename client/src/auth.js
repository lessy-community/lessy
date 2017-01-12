export default {
  isLoggedIn () {
    const token = window.localStorage.getItem('authentication_token')
    return token != null
  },
}
