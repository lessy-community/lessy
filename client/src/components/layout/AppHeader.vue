<template>
  <header class="app-header">
    <container row>
      <router-link to="/" class="header-title">Project Zero</router-link>
      <div class="separator"></div>
      <div v-if="user && user.isLoggedIn">
        {{ user.displayedName }}
        (<a href="#" @click.prevent="logout">Logout</a>)
      </div>
      <router-link to="/login" v-else>Log in</router-link>
    </container>
  </header>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'app-header',
  computed: {
    ...mapGetters({
      user: 'users/current',
    }),
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
