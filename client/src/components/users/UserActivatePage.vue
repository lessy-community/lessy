<template>
  <app-page name="user-activate" layout="single-form">
    <h1>{{ $t('users.activatePage.title') }}</h1>
    <p class="activate-info">{{ $t('users.activatePage.intro') }}</p>
    <user-activate-form
      :token="token"
      :on-success="onActivationSuccess"
    ></user-activate-form>
  </app-page>
</template>

<script>
  import UserActivateForm from './UserActivateForm'

  export default {
    components: {
      UserActivateForm,
    },

    data () {
      return {
        token: this.$route.params.token,
      }
    },

    methods: {
      onActivationSuccess () {
        window.location = '/'
      },
    },
  }
</script>
