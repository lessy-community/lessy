<template>
  <div id="app">
    <router-view v-if="ready"></router-view>
    <loading-layout v-else></loading-layout>
  </div>
</template>

<script>
  import LoadingLayout from 'src/components/general/LoadingLayout'

  import auth from 'src/auth'
  import { isRestrictedForAuth, isRestrictedForUnauth } from 'src/router'

  export default {
    components: {
      LoadingLayout,
    },

    data () {
      return {
        ready: false,
      }
    },

    mounted () {
      const shouldFetchUser = isRestrictedForAuth(this.$route) || (!isRestrictedForUnauth(this.$route) && auth.isLoggedIn())
      if (!shouldFetchUser) {
        this.ready = true
        return
      }

      this.$store
          .dispatch('users/getCurrent')
          .then((user) => {
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
