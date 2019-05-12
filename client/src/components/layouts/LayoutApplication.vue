<template>
  <app-layout name="application" :centered="centered">
    <app-menu :brand="$t('layouts.application.brand')" slot="menu">
      <app-menu-link to="/today" icon="calendar-o">{{ $t('layouts.application.today') }}</app-menu-link>
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
  import TermsOfServiceModal from '@/components/general/TermsOfServiceModal'

  export default {
    props: {
      centered: { type: Boolean },
    },

    components: {
      TermsOfServiceModal,
    },

    computed: {
      showTosModal () {
        const user = this.$store.getters['users/current']
        return user && !user.hasAcceptedTos
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
      background-color: $ly-color-pine-70;

      color: $ly-color-white;

      .app-header-right {
        background: linear-gradient(45deg, $ly-color-pine-70 3.5rem,
                                           $ly-color-grey-20 3.5rem,
                                           $ly-color-grey-20 4rem,
                                           $ly-color-pine-70 4rem,
                                           $ly-color-pine-70 4.5rem,
                                           $ly-color-grey-20 4.5rem);

        color: $ly-color-grey-90;
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
