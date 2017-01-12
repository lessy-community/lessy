<template>
  <header class="app-header">
    <container row>
      <router-link to="/" class="header-title">Project Zero</router-link>
      <div class="separator"></div>
      <template v-if="user && isLoggedIn">
        {{ user.username || user.email }}
        (<a href="#" @click.prevent="logout" v-if="isLoggedIn">Logout</a>)
      </template>
      <router-link to="/login" v-else>Log in</router-link>
    </container>
  </header>
</template>

<script>
import auth from '../../auth'
import { mapState } from 'vuex'

export default {
  name: 'app-header',
  computed: {
    ...mapState({
      user: (state) => state.users.current,
    }),
    isLoggedIn: auth.isLoggedIn,
  },
  methods: {
    logout () {
      this.$store.dispatch('users/logout')
      this.$router.push('/')
    }
  },
}
</script>

<style>
.app-header {
  padding: 1rem 1rem;
}
.app-header a {
  text-decoration: none;
}
</style>
