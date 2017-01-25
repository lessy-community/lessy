<template>
  <header class="app-header">
    <container row>
    <router-link to="/" class="header-title">{{ $t('layout.projectZero') }}</router-link>
      <div class="separator"></div>
      <div v-if="user && user.isLoggedIn">
        {{ user.displayedName }}
        (<a href="/logout" @click.prevent="logout">{{ $t('layout.logout') }}</a>)
      </div>
      <router-link v-else to="/login">{{ $t('layout.login') }}</router-link>
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
    margin-bottom: 10px;
    padding: 1rem 1rem;

    background-color: #0080b0;
    color: #fff;

    box-shadow: 0 1px 2px #aaa;
  }
  .app-header a {
    color: #fff;
  }
  .app-header .header-title {
    font-size: 1.1rem;
    font-weight: bold;
  }
  .app-header .header-title:hover {
    color: #ddd;
    text-decoration: none;
  }

</style>
