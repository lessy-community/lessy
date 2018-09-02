<template>
  <header class="layout-application-header">
    <h1 class="layout-application-header-title">{{ title }}</h1>
    <nav v-if="$slots.default" class="layout-application-header-nav">
      <div class="layout-application-header-nav-container">
        <slot></slot>
      </div>
    </nav>
    <div v-else class="layout-application-header-separator"></div>
    <div class="layout-application-header-user">
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
        window.location = '/'
      },
    },
  }
</script>

<style lang="scss">
  .layout-application-header {
    display: flex;

    align-items: stretch;

    color: $ly-color-white;

    > .layout-application-header-separator {
      flex-grow: 1;
    }
    > .layout-application-header-nav {
      flex-shrink: 1;
      flex-grow: 1;
    }
    > .layout-application-header-user {
      flex-shrink: 0;
    }
  }

  .layout-application-header-title,
  .layout-application-header-nav,
  .layout-application-header-user {
    display: flex;

    flex-direction: column;
    justify-content: center;
  }

  .layout-application-header-title {
    margin-top: 0;
    margin-bottom: 0;
    padding: 1rem 2rem;

    font-size: 1.1rem;
    font-weight: normal;
    line-height: 2.5rem;
    text-transform: uppercase;
  }

  .layout-application-header-nav-container {
    padding: .5rem 2rem;

    border-left: 1px solid $ly-color-white;
  }

  .layout-application-header-user {
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
    .layout-application-header-nav {
      white-space: nowrap;
      overflow-x: auto;
    }

    .layout-application-header-nav-container {
      padding: .5rem 1rem 1rem;

      border-left: none;
    }

    .layout-application-header-title,
    .layout-application-header-user {
      display: none;
    }
  }
</style>
