<template>
  <div class="home-page">
    <h1>Project Zero</h1>
    <register-form :on-success="onRegistrationSuccess" />
  </div>
</template>

<script>
import RegisterForm from '../forms/Register'

export default {
  name: 'home-page',
  components: {
    RegisterForm,
  },
  methods: {
    onRegistrationSuccess () {
      this.$router.push('/dashboard')
    },
  },
}
</script>
