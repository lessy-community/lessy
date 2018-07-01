<template>
  <app-layout name="user-login" no-tos-requirement>
    <welcome-header slot="header"></welcome-header>
    <app-page name="user-login">
      <div class="app-page-user-login-container">
        <h1>{{ $t('users.loginLayout.title') }}</h1>
        <user-login-form :on-success="onLoginSuccess"></user-login-form>
      </div>
    </app-page>
  </app-layout>
</template>

<script>
  import WelcomeHeader from 'src/components/general/WelcomeHeader'
  import UserLoginForm from './UserLoginForm'

  export default {
    components: {
      WelcomeHeader,
      UserLoginForm,
    },

    methods: {
      onLoginSuccess () {
        window.location = '/dashboard'
      },
    },
  }
</script>

<style lang="scss">
  .app-page-user-login {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);

    h1 {
      text-align: center;
    }
  }

  .app-page-user-login-container {
    max-width: 30rem;
    margin-left: auto;
    margin-right: auto;
  }
</style>
