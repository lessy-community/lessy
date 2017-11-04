<template>
  <form @submit.prevent="register">
    <form-group
      :label="$t('users.registerForm.emailLabel')"
      target="email"
      required
      :tip="getErrors('User', 'email')"
      :invalid="isInError('User', 'email')"
    >
      <email-field id="email" v-model="email" required />
    </form-group>

    <form-group actions>
      <ly-button type="primary" submit>{{ $t('users.registerForm.submit') }}</ly-button>
      {{ $t('users.registerForm.or') }}
      <router-link to="/login">{{ $t('users.registerForm.login') }}</router-link>
    </form-group>
  </form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
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
