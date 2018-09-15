<template>
  <aside class="app-menu">
    <header class="app-menu-header">
      <ly-button type="ghost" icon="bars" @click="toggleMobileNavigation">Menu</ly-button>

      <router-link class="app-brand" :to="home">
        {{ brand }}
      </router-link>
    </header>

    <nav :class="['app-menu-navigation', { visible: showMobileNavigation }]">
      <slot></slot>
    </nav>
  </aside>
</template>

<script>
  import LyButton from 'src/components/Ly/LyButton'

  export default {
    props: {
      brand: { type: String, required: true },
      home: { type: String, default: '/' },
    },

    components: {
      LyButton,
    },

    data () {
      return {
        showMobileNavigation: false,
      }
    },

    methods: {
      toggleMobileNavigation () {
        this.showMobileNavigation = !this.showMobileNavigation
      },
    },
  }
</script>

<style lang="scss">
  .app-menu {
    position: relative;

    background: linear-gradient(225deg, $ly-color-pine-60 25rem,
                                        $ly-color-pine-70 25rem);

    a {
      color: $ly-color-white;
      text-decoration: none;

      &:hover { color: $ly-color-white; }
      &:focus { color: $ly-color-white; }
    }

    .app-brand {
      font-weight: bold;
    }

    .app-menu-header {
      padding: 1rem 2rem;

      line-height: 2.5rem;

      .ly-button {
        display: none;
      }
    }

    .app-menu-navigation {
      position: sticky;
      top: 0;

      padding-top: .5rem;
      padding-bottom: .5rem;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-menu {
      background: $ly-color-pine-60;

      .app-menu-header .ly-button {
        display: inline-block;

        color: $ly-color-white;
      }

      .app-menu-navigation {
        padding-top: 1rem;

        background: $ly-color-pine-50;
      }
      .app-menu-navigation:not(.visible) {
        display: none;
      }

      .app-menu-header {
        padding: .5rem 1rem;
      }
    }
  }
</style>
