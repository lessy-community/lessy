<template>
  <app-layout name="user-login">
    <welcome-header slot="header"></welcome-header>
    <app-page name="user-login">
      <ly-text-container margined>
        <h1>{{ $t('users.loginLayout.title') }}</h1>
        <user-login-form :on-success="onLoginSuccess"></user-login-form>
      </ly-text-container>
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
  }
</style>
