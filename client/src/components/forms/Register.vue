<template>
  <form @submit.prevent="register">
    <form-group
      :label="$t('forms.register.emailLabel')"
      target="email"
      required
      :tip="getErrors('User', 'email')"
      :invalid="isInError('User', 'email')"
    >
      <email-field id="email" v-model="email" required />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.register.submit') }}</btn>
    </form-group>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'register-form',

    mixins: [ErrorsHandler],

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
                   .catch(this.setFailureErrors)
      },

    },

  }
</script>
