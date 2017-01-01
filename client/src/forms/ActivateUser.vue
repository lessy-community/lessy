<template>
  <form @submit.prevent="activate">
    <div>
      <label for="username">Username (only lowercase letters, underscore and dash) *</label>
      <input v-model="username" type="text" id="username" pattern="[a-z_\-]{1,}" required />
    </div>

    <div>
      <label for="password">Password *</label>
      <password-field v-model="password" id="password" required />
    </div>

    <input type="submit" value="Activate my account" />
  </form>
</template>

<script>
import PasswordField from '../components/PasswordField'

export default {
  name: 'activate-user-form',
  components: {
    PasswordField,
  },
  props: {
    'token': { type: String, required: true },
    'onSuccess': { type: Function, required: true },
  },
  data () {
    return {
      username: '',
      password: '',
    }
  },
  methods: {
    activate () {
      this.$store.dispatch('users/activate', {
        token: this.token,
        username: this.username,
        password: this.password,
      }).then(this.onSuccess)
    },
  },
}
</script>
