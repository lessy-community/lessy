<template>
  <div class="home-page">
    <h1>{{ $t('pages.home.title') }}</h1>
    <p>{{ $t('pages.home.intro') }}</p>
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

  .home-page .form-group {
    width: 500px;
    margin-left: auto;
    margin-right: auto;
  }

</style>
