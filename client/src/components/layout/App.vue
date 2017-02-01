<template>
  <div id="app">
    <app-header></app-header>
    <container row class="app-container">
      <app-sidebar></app-sidebar>
      <router-view v-if="ready" class="app-content adapt"></router-view>
      <loading-page v-else class="app-content adapt"></loading-page>
    </container>
  </div>
</template>

<script>
  import AppHeader from './AppHeader'
  import AppSidebar from './AppSidebar'

  import LoadingPage from '../pages/Loading'

  import auth from '../../auth'
  import { isRestrictedForAuth, isRestrictedForUnauth } from '../../router'

  export default {

    name: 'app',

    components: {
      AppHeader,
      AppSidebar,
      LoadingPage,
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
      } else {
        this.$store
            .dispatch('users/getCurrent')
            .then((user) => {
              this.ready = true
            })
            .catch(() => {
              // having troubles to fetch current user? It probably means token
              // expired or user does not exist. Logout and return to home page.
              auth.logout()
              this.$router.push('/')
              this.ready = true
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

    font-family: 'Open Sans', sans-serif;

    background-color: #fafafa;
  }

  a {
    color: #0080b0;
    text-decoration: none;
  }
  a:hover {
    text-decoration: underline;
  }

  h1 {
    margin-top: 0;
  }

  .app-container {
    min-height: calc(100vh - 66px);
    margin-top: -10px;
  }
  .app-container > .app-content {
    padding: 25px;

    background-color: #fff;
    border-left: 1px solid #eee;
  }

</style>
