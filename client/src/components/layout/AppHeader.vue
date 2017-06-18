<template>
  <header class="app-header">
    <container row align="baseline">
      <btn type="link" @click="toggleSidebar">
        <icon name="bars"></icon>
      </btn>
      <router-link to="/" class="header-title">{{ $t('layout.projectZero') }}</router-link>
      <div class="separator"></div>
      <div v-if="user && user.isLoggedIn" class="header-profile">
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
      },

      toggleSidebar () {
        document.body.classList.toggle('with-app-sidebar')
      },
    },
  }
</script>

<style lang="scss">

  .app-header {
    margin-bottom: 10px;
    padding: 1rem 1rem;

    background-color: $color-primary;
    color: #fff;
  }
  .app-header a {
    color: #fff;
  }
  .app-header .btn.link {
    margin: 0;
    padding: 4px 6px;

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

  @media(max-width: $small-screen-width) {
    .app-header > .container.row {
      flex-direction: row;
    }

    .app-header .header-profile {
      display: none;
    }
  }

</style>
