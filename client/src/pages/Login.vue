<template>
  <div class="login-page">
    <login-form :on-success="onLoginSuccess" />
  </div>
</template>

<script>
import LoginForm from '../forms/Login'

export default {
  name: 'login-page',
  components: {
    LoginForm,
  },
  methods: {
    onLoginSuccess () {
      this.$router.push('/dashboard')
    },
  },
}
</script>
