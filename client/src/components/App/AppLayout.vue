<template>
  <section :class="['app-layout', `app-layout-${name}`]">
    <slot name="menu"></slot>
    <div class="app-page-container">
      <slot name="header"></slot>
      <slot></slot>
    </div>

    <terms-of-service-modal v-if="showTosModal"></terms-of-service-modal>
  </section>
</template>

<script>
  import { mapGetters } from 'vuex'

  import TermsOfServiceModal from 'src/components/general/TermsOfServiceModal'

  export default {
    props: {
      name: { type: String, required: true },
      noTosRequirement: { type: Boolean, default: false },
    },

    components: {
      TermsOfServiceModal,
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),

      showTosModal () {
        return !this.noTosRequirement && this.user && !this.user.hasAcceptedTos
      }
    },
  }
</script>

<style lang="scss">
  .app-layout {
    display: flex;
    min-height: 100vh;

    align-items: stretch;

    > .app-menu {
      width: 15rem;

      flex-shrink: 0;
    }
    > .app-page-container {
      flex-grow: 1;
    }
  }

  .app-page-container {
    display: flex;
    flex-direction: column;

    > .app-page {
      flex-grow: 1;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-layout {
      flex-direction: column;

      > .app-menu {
        width: auto;
      }
    }
  }
</style>
