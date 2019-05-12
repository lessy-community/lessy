<template>
  <aside class="app-menu">
    <header class="app-menu-header">
      <ly-button type="ghost" icon="bars" @click="toggleMobileNavigation">Menu</ly-button>

      <router-link :to="home" class="app-menu-home">
        <app-logo flavour="inversed" />
        <span v-if="subbrand" class="subbrand">
          {{ subbrand }}
        </span>
      </router-link>
    </header>

    <nav :class="['app-menu-navigation', { visible: showMobileNavigation }]">
      <slot></slot>
    </nav>
  </aside>
</template>

<script>
  import LyButton from '@/components/Ly/LyButton'

  export default {
    props: {
      subbrand: { type: String },
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

    background: linear-gradient(225deg, $ly-color-pine-70 25rem,
                                        $ly-color-pine-80 25rem);

    a {
      color: $ly-color-white;
      text-decoration: none;

      &:hover { color: $ly-color-white; }
      &:focus { color: $ly-color-white; }
    }

    .app-menu-home {
      display: block;
    }

    .subbrand {
      font-size: 1.5rem;

      @media(max-width: $small-screen-width) {
        display: none;
      }
    }

    .app-menu-header {
      display: flex;
      padding: 1rem 2rem;

      line-height: 2.5rem;

      .ly-button {
        display: none;
        padding-left: 1rem;
        padding-right: 1rem;
      }

      .app-menu-home {
        flex-grow: 1;
      }
    }

    .app-menu-navigation {
      position: sticky;
      top: 0;

      padding-top: .25rem;
      padding-bottom: .25rem;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-menu {
      background: $ly-color-pine-70;

      .app-menu-header .ly-button {
        display: inline-block;

        color: $ly-color-white;
      }

      .app-menu-header .app-logo {
        justify-content: center;
      }

      .app-menu-navigation {
        padding-top: 1rem;

        background: $ly-color-pine-70;
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
