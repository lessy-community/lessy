<template>
  <app-layout name="application" no-legacy>
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
  .app-layout-application .app-layout-main {
    border-radius: .25rem 0 0 0;
  }
</style>
