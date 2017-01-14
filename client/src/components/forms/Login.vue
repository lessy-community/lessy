<template>
  <form @submit.prevent="login">
    <div v-if="error">
      {{ error }}
    </div>

    <div>
      <label for="username">Username *</label>
      <input v-model="username" type="text" id="username" pattern="[a-z_\-]{1,}" required />
    </div>

    <div>
      <label for="password">Password *</label>
      <password-field v-model="password" id="password" required />
    </div>

    <btn submit>Login</btn>
  </form>
</template>

<script>
export default {
  name: 'login-form',
  props: {
    'onSuccess': { type: Function, required: true },
  },
  data () {
    return {
      username: '',
      password: '',
      error: '',
    }
  },
  methods: {
    login () {
      this.$store
        .dispatch('users/login', {
          username: this.username,
          password: this.password,
        })
        .then(this.onSuccess)
        .catch((error) => {
          this.error = error.data.message
        })
    },
  },
}
</script>
