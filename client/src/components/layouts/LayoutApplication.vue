<template>
  <app-layout name="application">
    <app-menu :title="$t('layouts.application.title')" slot="menu">
      <app-menu-link to="/dashboard" icon="tachometer">{{ $t('layouts.application.dashboard') }}</app-menu-link>
      <app-menu-link to="/tasks" icon="check-circle">{{ $t('layouts.application.tasks') }}</app-menu-link>
      <app-menu-link to="/projects" icon="folder-open">{{ $t('layouts.application.projects') }}</app-menu-link>
    </app-menu>
    <slot name="header" slot="header"></slot>

    <slot></slot>

    <terms-of-service-modal v-if="showTosModal"></terms-of-service-modal>
  </app-layout>
</template>

<script>
  import { mapGetters } from 'vuex'

  import AppMenu from 'src/components/App/AppMenu'
  import AppMenuLink from 'src/components/App/AppMenuLink'

  import TermsOfServiceModal from 'src/components/general/TermsOfServiceModal'

  export default {
    components: {
      AppMenu,
      AppMenuLink,
      TermsOfServiceModal,
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),

      showTosModal () {
        return this.user && !this.user.hasAcceptedTos
      }
    },
  }
</script>

<style lang="scss">
  .app-layout-application {
    .app-layout-main {
      border-radius: .25rem 0 0 0;
    }

    .app-header {
      background-color: $ly-color-pine-60;

      color: $ly-color-white;

      .app-header-right {
        background: linear-gradient(45deg, $ly-color-pine-60 3.5rem,
                                           $ly-color-grey-20 3.5rem,
                                           $ly-color-grey-20 4rem,
                                           $ly-color-pine-60 4rem,
                                           $ly-color-pine-60 4.5rem,
                                           $ly-color-grey-20 4.5rem);

        color: $ly-color-grey-90;
      }
    }

    .app-header-link {
      color: $ly-color-white;

      opacity: .7;
      transition: opacity .2s ease-in-out;

      &:hover {
        opacity: 1;
      }
      &.active {
        opacity: 1;
      }
    }
  }

  @media(max-width: $small-screen-width) {
    .app-layout-application {
      .app-layout-main {
        border-radius: 0;
      }

      .app-header {
        padding-top: .5rem;
      }
    }
  }
</style>
