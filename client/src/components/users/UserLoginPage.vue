<template>
  <app-page name="user-login" layout="single-form">
    <h1>{{ $t('users.loginPage.title') }}</h1>
    <user-login-form :on-success="onLoginSuccess"></user-login-form>
  </app-page>
</template>

<script>
  import UserLoginForm from './UserLoginForm'

  export default {
    components: {
      UserLoginForm,
    },

    methods: {
      onLoginSuccess () {
        window.location = '/'
      },
    },
  }
</script>
