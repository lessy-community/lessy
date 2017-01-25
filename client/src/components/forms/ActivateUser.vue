<template>
  <form @submit.prevent="activate">
    <form-group :label="$t('forms.activateUser.usernameLabel')" :tip="$t('forms.activateUser.usernameTip')" target="username" required>
      <text-field id="username" v-model="username" pattern="[a-z_\-]{1,}" required />
    </form-group>

    <form-group :label="$t('forms.activateUser.passwordLabel')" target="password" required>
      <password-field id="password" v-model="password" required />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.activateUser.submit') }}</btn>

      <div v-if="error">
        {{ error }}
      </div>
    </form-group>
  </form>
</template>

<script>
export default {
  name: 'activate-user-form',
  props: {
    'token': { type: String, required: true },
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
    activate () {
      this.$store
        .dispatch('users/activate', {
          token: this.token,
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
