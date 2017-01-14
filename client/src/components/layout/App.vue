<template>
  <div id="app">
    <app-header></app-header>
    <container>
      <router-view v-if="ready"></router-view>
      <error-page v-else-if="error" :message="error"></error-page>
      <loading-page v-else></loading-page>
    </container>
  </div>
</template>

<script>
  import AppHeader from './AppHeader'

  import ErrorPage from '../pages/Error'
  import LoadingPage from '../pages/Loading'

  import auth from '../../auth'
  import { isRestrictedForAuth, isRestrictedForUnauth } from '../../router'

  export default {

    name: 'app',

    components: {
      AppHeader,
      ErrorPage,
      LoadingPage,
    },

    data () {
      return {
        ready: false,
        error: null,
      }
    },

    mounted () {
      const shouldFetchUser = isRestrictedForAuth(this.$route) || (!isRestrictedForUnauth(this.$route) && auth.isLoggedIn())
      if (!shouldFetchUser) {
        this.ready = true
      } else {
        this.$store
            .dispatch('users/getCurrent')
            .then((user) => {
              this.ready = true
            })
            .catch((error) => {
              this.error = error.data.message
            })
      }
    },

    destroyed () {
      this.$store.commit('users/resetCurrent', true)
    },

  }
</script>

<style>

  * {
    box-sizing: border-box;
  }

  html,
  body {
    margin: 0;
    padding: 0;
  }

</style>
