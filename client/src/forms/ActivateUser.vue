<template>
  <form @submit.prevent="activate">
    <div>
      <label for="username">Username (only lowercase letters, underscore and dash) *</label>
      <input v-model="username" type="text" id="username" pattern="[a-z_\-]{1,}" required />
    </div>

    <div>
      <label for="password">Password *</label>
      <input v-model="password" type="password" id="password" required />
    </div>

    <input type="submit" value="Activate my account" />
  </form>
</template>

<script>
export default {
  name: 'activate-user-form',
  props: {
    'token': { type: String, required: true },
  },
  data () {
    return {
      username: '',
      password: '',
    }
  },
  methods: {
    activate: function (event) {
      window.fetch(`/api/users/${this.token}/activate`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          user: {
            username: this.username,
            password: this.password,
          },
        }),
      })
    }
  }
}
</script>
