<template>
  <div class="home-page">
    <h1>Project Zero</h1>
    <register-form></register-form>
  </div>
</template>

<script>
import RegisterForm from '../forms/Register'

export default {
  name: 'home-page',
  components: {
    RegisterForm,
  },
}
</script>
