<template>
  <form @submit.prevent="register">
    <div>
      <label for="email">Email *</label>
      <input v-model="email" type="email" id="email" required />
    </div>

    <input type="submit" value="Let me in" />
    <router-link to="/login">Log in</router-link>
  </form>
</template>

<script>
export default {
  name: 'register-form',
  props: {
    'onSuccess': { type: Function, required: true },
  },
  data () {
    return {
      email: '',
    }
  },
  methods: {
    register () {
      this.$store.dispatch('users/register', this.email)
                 .then(this.onSuccess)
    },
  },
}
</script>
