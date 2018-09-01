<template>
  <div v-if="noLegacy" :class="['app-layout', `app-layout-${name}`]">
    <slot name="menu"></slot>
    <div class="app-page-container">
      <slot name="header"></slot>
      <main class="app-layout-main">
        <slot></slot>
      </main>
    </div>
  </div>

  <section v-else :class="['app-layout', `app-layout-${name}`]">
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
      noLegacy: { type: Boolean, default: false },
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

    > .app-page,
    > .app-layout-main {
      flex-grow: 1;
    }
  }

  .app-layout-main {
    padding-top: 1rem;
    padding-bottom: 5rem;
    padding-left: 2rem;
    padding-right: 2rem;

    background-color: $ly-color-grey-10;
  }

  @media(max-width: $small-screen-width) {
    .app-layout {
      flex-direction: column;

      > .app-menu {
        width: auto;
      }
    }

    .app-layout-main {
      padding-left: 1rem;
      padding-right: 1rem;
    }
  }
</style>
