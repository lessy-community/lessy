<template>
  <ly-form @submit="register">
    <ly-form-group>
      <ly-form-input
        type="email"
        v-model="email"
        name="email"
        :placeholder="$t('users.registerForm.emailPlaceholder')"
        :label="$t('users.registerForm.emailLabel')"
        :error="getErrors('User', 'email')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" size="large" submit>
        {{ $t('users.registerForm.submit') }}
      </ly-button>
      <router-link to="/login">
        {{ $t('users.registerForm.login') }}
      </router-link>
    </ly-form-group>
  </ly-form>
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
