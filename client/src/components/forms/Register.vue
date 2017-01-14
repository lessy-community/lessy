<template>
  <form @submit.prevent="register">
    <div>
      <label for="email">Email *</label>
      <input v-model="email" type="email" id="email" required />
    </div>

    <btn submit>Let me in</btn>
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
