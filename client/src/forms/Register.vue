<template>
  <form @submit.prevent="register">
    <div>
      <label for="email">Email *</label>
      <input v-model="email" type="email" id="email" required />
    </div>

    <input type="submit" value="Let me in" />
  </form>
</template>

<script>
export default {
  name: 'register-form',
  data () {
    return {
      email: '',
    }
  },
  methods: {
    register: function (event) {
      window.fetch('/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          user: {
            email: this.email,
          },
        }),
      })
    },
  },
}
</script>
