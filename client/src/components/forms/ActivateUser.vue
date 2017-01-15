<template>
  <form @submit.prevent="activate">
    <form-group label="Username" tip="Only lowercase letters, underscore and dash" target="username" required>
      <text-field id="username" v-model="username" pattern="[a-z_\-]{1,}" required />
    </form-group>

    <form-group label="Password" target="password" required>
      <password-field id="password" v-model="password" required />
    </form-group>

    <form-group actions>
      <btn submit>Activate my account</btn>

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
