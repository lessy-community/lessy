<template>
  <app-layout name="terms-of-service" no-tos-requirement>
    <welcome-header slot="header"></welcome-header>
    <app-page name="terms-of-service">
      <template v-if="ready">
        <div class="ly-text-container margined">
          <h1>{{ $t('general.termsOfServiceLayout.title') }}</h1>

          <p class="text-secondary">
            {{ $t('general.termsOfServiceLayout.version', { version: termsOfService.version }) }}
          </p>

          <div v-if="user && !user.hasAcceptedTos" class="tos-changed">
            {{ $t('general.termsOfServiceLayout.changed') }}
          </div>
        </div>

        <div v-html="termsOfService.content"></div>

        <div v-if="user && !user.hasAcceptedTos" class="accept-tos-footer">
          <router-link to="/">
            {{ $t('general.termsOfServiceLayout.goBack') }}
          </router-link>
          <ly-button type="primary" size="large" @click="acceptTos">
            {{ $t('general.termsOfServiceLayout.accept') }}
          </ly-button>
        </div>
        <div v-else class="accept-tos-footer">
          <router-link to="/">
            {{ $t('general.termsOfServiceLayout.goBack') }}
          </router-link>
        </div>
      </template>
      <div v-else class="ly-text-container margined">
        <h1>{{ $t('general.termsOfServiceLayout.title') }}</h1>
        <h2>{{ $t('general.termsOfServiceLayout.loading') }}</h2>
      </div>
    </app-page>
  </app-layout>
</template>

<script>
  import WelcomeHeader from './WelcomeHeader'

  import { mapGetters } from 'vuex'

  export default {
    components: {
      WelcomeHeader,
    },

    data () {
      return {
        ready: false,
      }
    },

    computed: {
      ...mapGetters({
        termsOfService: 'termsOfServices/current',
        user: 'users/current',
      }),
    },

    methods: {
      acceptTos () {
        this.$store
          .dispatch('users/acceptTermsOfService')
          .then(() => { this.$router.push('/') })
      },
    },

    mounted () {
      this.$store
        .dispatch('termsOfServices/getCurrent')
        .then(() => { this.ready = true })
    },
  }
</script>

<style lang="scss">
  .app-page-terms-of-service {
    padding-bottom: 10rem;
  }

  .app-page-terms-of-service .ly-columns {
    max-width: 60rem;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 5rem;

    text-align: center;
  }

  .app-page-terms-of-service .tos-changed {
    padding: .25rem .5rem;

    color: $ly-color-white;
    text-align: center;
    font-weight: bold;

    background-color: $ly-color-pine-50;
  }

  .app-page-terms-of-service .accept-tos-footer {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;

    padding: 1rem 2rem;

    background-color: $ly-color-grey-10;
    box-shadow: 0 0 1px $ly-color-grey-50;

    text-align: center;

    a {
      margin-right: 1rem;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-page-terms-of-service .accept-tos-footer a {
      display: block;
      margin-right: 0;
      margin-bottom: 1rem;
    }
  }
</style>
