<template>
  <app-page name="user-password-new" layout="single-form">
    <h1>{{ $t('users.passwordNewPage.title') }}</h1>
    <p>{{ $t('users.passwordNewPage.intro') }}</p>
    <user-password-new-form
      :token="token"
      @success="onFormSuccess"
    ></user-password-new-form>
  </app-page>
</template>

<script>
  import UserPasswordNewForm from './UserPasswordNewForm'

  export default {
    components: {
      UserPasswordNewForm,
    },

    data () {
      return {
        token: this.$route.params.token,
      }
    },

    methods: {
      onFormSuccess () {
        window.location = '/dashboard'
      },
    },
  }
</script>
