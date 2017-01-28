<template>
  <form @submit.prevent="login">
    <div v-if="error">
      {{ error }}
    </div>

    <form-group :label="$t('forms.login.usernameLabel')" target="username" required>
      <text-field id="username" v-model="username" pattern="[a-z_\-]{1,}" required />
    </form-group>
    <form-group :label="$t('forms.login.passwordLabel')" target="password" required>
      <password-field id="password" v-model="password" required />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.login.submit') }}</btn>
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
