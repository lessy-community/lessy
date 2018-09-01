<template>
  <div id="app">
    <router-view v-if="ready"></router-view>
    <loading-page v-else></loading-page>
  </div>
</template>

<script>
  import LoadingPage from 'src/components/general/LoadingPage'

  import { mapGetters } from 'vuex'
  import auth from 'src/auth'

  export default {
    components: {
      LoadingPage,
    },

    data () {
      return {
        ready: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },

    watch: {
      user: function (user) {
        if (user == null) {
          // `user` can become null at logout.
          // To avoid access to a null value, we force ready to false so it
          // shows the loading page (redirection to home page happens on the
          // next tick)
          this.ready = false
        }
      },
    },

    mounted () {
      const shouldFetchUser = auth.isLoggedIn()
      if (!shouldFetchUser) {
        this.ready = true
        return
      }

      this.$store
          .dispatch('users/getCurrent')
          .then(() => {
            return Promise.all([
              this.$store.dispatch('tasks/list'),
              this.$store.dispatch('projects/list'),
            ])
          })
          .then(() => {
            this.ready = true
          })
          .catch(() => {
            // having troubles to fetch current user? It probably means token
            // expired or user does not exist. Logout and return to home page.
            auth.logout()
            window.location = '/'
          })
    },
  }
</script>
