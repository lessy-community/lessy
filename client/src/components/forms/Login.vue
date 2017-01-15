<template>
  <form @submit.prevent="login">
    <div v-if="error">
      {{ error }}
    </div>

    <form-group label="Username" target="username" required>
      <text-field id="username" v-model="username" pattern="[a-z_\-]{1,}" required />
    </form-group>
    <form-group label="Password" target="password" required>
      <password-field id="password" v-model="password" required />
    </form-group>

    <form-group actions>
      <btn submit>Login</btn>
    </form-group>
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
