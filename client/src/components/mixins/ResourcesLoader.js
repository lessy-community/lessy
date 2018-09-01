import auth from 'src/auth'

export default {
  computed: {
    resourcesReady () {
      return this.$store.getters['global/resourcesReady']
    },
  },

  mounted () {
    this.$store
        .dispatch('users/getCurrent')
        .then(() => {
          return Promise.all([
            this.$store.dispatch('tasks/list'),
            this.$store.dispatch('projects/list'),
          ])
        })
        .then(() => {
          this.$store.commit('global/setResourcesReady', true)
        })
        .catch(() => {
          // having troubles to fetch current user? It probably means token
          // expired or user does not exist. Logout and return to home page.
          auth.logout()
          window.location = '/'
        })
  },
}
