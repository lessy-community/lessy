<template>
  <ly-form @submit="resetPassword" :error="getErrors() || getErrors('/user')" margined>
    <ly-form-group>
      <ly-form-input
        type="email"
        v-model="email"
        name="email"
        :label="$t('users.passwordResetForm.emailLabel')"
        :error="getErrors('/user/email')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions-block">
      <ly-button type="primary" size="large" submit>
        {{ $t('users.passwordResetForm.submit') }}
      </ly-button>
      <router-link to="/login">{{ $t('users.passwordResetForm.login') }}</router-link>
      <hr />
      <router-link to="/">{{ $t('users.passwordResetForm.register') }}</router-link>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    data () {
      return {
        email: '',
      }
    },

    methods: {
      resetPassword () {
        this.$store
          .dispatch('users/resetPassword', { email: this.email })
          .then(() => { this.$emit('success', this.email) })
          .catch((errors) => {
            this.$emit('fail', {
              errors: errors.data.errors,
              email: this.email
            })
            this.setFailureErrors(errors)
          })
      },
    },
  }
</script>
