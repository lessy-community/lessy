<template>
  <div class="activate-user-page">
    <h1>Activate your account</h1>
    <p>To continue, you have to pick a unique username and a password so you can login to your account later.</p>
    <activate-user-form
      :token="token"
      :on-success="onActivationSuccess"
    />
  </div>
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
