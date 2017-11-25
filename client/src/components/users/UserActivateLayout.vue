<template>
  <app-layout name="user-activate">
    <welcome-header slot="header"></welcome-header>
    <app-page name="user-activate">
      <div class="app-page-user-activate-container">
        <h1>{{ $t('users.activateLayout.title') }}</h1>
        <p class="activate-info">{{ $t('users.activateLayout.intro') }}</p>
        <user-activate-form
          :token="token"
          :on-success="onActivationSuccess"
        ></user-activate-form>
      </div>
    </app-page>
  </app-layout>
</template>

<script>
  import WelcomeHeader from 'src/components/general/WelcomeHeader'
  import UserActivateForm from './UserActivateForm'

  export default {
    components: {
      WelcomeHeader,
      UserActivateForm,
    },

    data () {
      return {
        token: this.$route.params.token,
      }
    },

    methods: {
      onActivationSuccess () {
        window.location = '/dashboard'
      },
    },
  }
</script>

<style lang="scss">
  .app-page-user-activate {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);

    h1, .activate-info {
      text-align: center;
    }
  }

  .app-page-user-activate-container {
    max-width: 30rem;
    margin-left: auto;
    margin-right: auto;
  }
</style>
