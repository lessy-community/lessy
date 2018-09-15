<template>
  <app-layout name="profile">
    <app-menu :brand="$t('layouts.profile.brand')" slot="menu">
      <app-menu-link to="/profile">
        {{ $t('layouts.profile.profile') }}
      </app-menu-link>
      <app-menu-link to="/today" icon="home">
        {{ $t('layouts.profile.backToApp') }}
      </app-menu-link>
    </app-menu>

    <app-header :title="$t('layouts.profile.title')" slot="header">
      <user-popover slot="right">
      </user-popover>
    </app-header>

    <slot></slot>

    <terms-of-service-modal v-if="showTosModal"></terms-of-service-modal>
  </app-layout>
</template>

<script>
  import { mapGetters } from 'vuex'

  import TermsOfServiceModal from 'src/components/general/TermsOfServiceModal'
  import UserPopover from 'src/components/users/UserPopover'

  export default {
    components: {
      TermsOfServiceModal,
      UserPopover,
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
