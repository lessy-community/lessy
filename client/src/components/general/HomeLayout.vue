<template>
  <app-layout name="home">
    <welcome-header slot="header"></welcome-header>
    <app-page name="home">
      <ly-text-container margined>
        <h1>{{ $t('general.homeLayout.title') }}</h1>
        <p>{{ $t('general.homeLayout.intro') }}</p>
        <user-register-form :on-success="onRegistrationSuccess"></user-register-form>
      </ly-text-container>
    </app-page>
  </app-layout>
</template>

<script>
  import UserRegisterForm from 'src/components/users/UserRegisterForm'
  import WelcomeHeader from './WelcomeHeader'

  export default {
    components: {
      WelcomeHeader,
      UserRegisterForm,
    },

    methods: {
      onRegistrationSuccess () {
        this.$router.push('/dashboard')
      },
    },
  }
</script>

<style lang="scss">
  .app-page-home {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);
  }
</style>
