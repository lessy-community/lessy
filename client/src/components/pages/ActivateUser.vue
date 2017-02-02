<template>
  <app-content contentClass="activate-user-page">
    <h1>{{ $t('pages.activateUser.title') }}</h1>
    <p>{{ $t('pages.activateUser.intro') }}</p>
    <activate-user-form
      :token="token"
      :on-success="onActivationSuccess"
    />
  </app-content>
</template>

<script>
import ActivateUserForm from '../forms/ActivateUser'

export default {
  name: 'activate-user-page',
  components: {
    ActivateUserForm,
  },
  data () {
    return {
      token: this.$route.params.token,
    }
  },
  methods: {
    onActivationSuccess () {
      this.$router.push('/dashboard')
    },
  },
}
</script>
