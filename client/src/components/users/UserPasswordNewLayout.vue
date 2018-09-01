<template>
  <app-layout name="user-password-new" no-tos-requirement>
    <welcome-header slot="header"></welcome-header>
    <app-page name="user-password-new">
      <div class="app-page-user-password-new-container">
        <h1>{{ $t('users.passwordNewLayout.title') }}</h1>
        <p>{{ $t('users.passwordNewLayout.intro') }}</p>
        <user-password-new-form
          :token="token"
          @success="onFormSuccess"
        ></user-password-new-form>
      </div>
    </app-page>
  </app-layout>
</template>

<script>
  import WelcomeHeader from 'src/components/general/WelcomeHeader'
  import UserPasswordNewForm from './UserPasswordNewForm'

  export default {
    components: {
      WelcomeHeader,
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

<style lang="scss">
  .app-page-user-password-new {
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

  .app-page-user-password-new-container {
    max-width: 30rem;
    margin-left: auto;
    margin-right: auto;
  }
</style>
