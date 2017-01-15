<template>
  <form @submit.prevent="register">
    <form-group label="Email" target="email" required>
      <email-field id="email" v-model="email" required />
    </form-group>

    <form-group actions>
      <btn submit>Let me in</btn>
    </form-group>
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
