<template>
  <div class="home-page">
    <h1>Welcome on Project Zero!</h1>
    <p>A new era begins for the projects and todos managers</p>
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

<style>
.home-page {
  text-align: center;
}
</style>
