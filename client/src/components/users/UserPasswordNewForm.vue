<template>
  <ly-form @submit="resetPassword" :error="getErrors() || getErrors('/user')">
    <ly-form-group>
      <ly-form-input
        type="password"
        v-model="password"
        name="password"
        :label="$t('users.passwordNewForm.passwordLabel')"
        :error="getErrors('/user/password')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions-block">
      <ly-button type="primary" size="large" submit>
        {{ $t('users.passwordNewForm.submit') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      token: { type: String, required: true },
    },

    data () {
      return {
        password: '',
      }
    },

    methods: {
      resetPassword () {
        this.$store
          .dispatch('users/changePassword', {
            token: this.token,
            password: this.password,
          })
          .then(() => this.$emit('success'))
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
