<template>
  <header class="app-header">
    <h1 class="app-header-title">{{ title }}</h1>
    <nav v-if="$slots.default" class="app-header-nav">
      <div class="app-header-nav-container">
        <slot></slot>
      </div>
    </nav>
    <div v-else class="app-header-separator"></div>
    <div class="app-header-user">
      <div>
        {{ user.displayedName }}
        <ly-button type="ghost" @click="logout">{{ $t('app.appHeader.logout') }}</ly-button>
      </div>
    </div>
  </header>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: {
      title: { type: String, required: true },
    },

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
    },
  }
</script>

<style lang="scss">
  .app-header {
    display: flex;

    align-items: stretch;

    color: $ly-color-white;

    > .app-header-separator {
      flex-grow: 1;
    }
    > .app-header-nav {
      flex-shrink: 1;
      flex-grow: 1;
    }
    > .app-header-user {
      flex-shrink: 0;
    }
  }

  .app-header-title,
  .app-header-nav,
  .app-header-user {
    display: flex;

    flex-direction: column;
    justify-content: center;
  }

  .app-header-title {
    margin-top: 0;
    margin-bottom: 0;
    padding: 1rem 2rem;

    font-size: 1.1rem;
    font-weight: normal;
    line-height: 2.5rem;
    text-transform: uppercase;
  }

  .app-header-nav-container {
    padding: .5rem 2rem;

    border-left: 1px solid $ly-color-white;
  }

  .app-header-user {
    padding: 1rem 2rem 1rem 6rem;

    color: $ly-color-grey-90;
    line-height: 2.5rem;
    white-space: nowrap;

    background: linear-gradient(45deg, $ly-color-pine-60 3.5rem,
                                       $ly-color-grey-20 3.5rem,
                                       $ly-color-grey-20 4rem,
                                       $ly-color-pine-60 4rem,
                                       $ly-color-pine-60 4.5rem,
                                       $ly-color-grey-20 4.5rem);
  }

  @media(max-width: $small-screen-width) {
    .app-header-nav {
      white-space: nowrap;
      overflow-x: auto;
    }

    .app-header-nav-container {
      padding: .5rem 1rem 1rem;

      border-left: none;
    }

    .app-header-title,
    .app-header-user {
      display: none;
    }
  }
</style>
