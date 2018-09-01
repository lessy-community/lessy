<template>
  <ly-form @submit="login" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="username"
        v-model="username"
        pattern="[a-z_\-]{1,25}"
        :label="$t('users.loginForm.usernameLabel')"
        :error="getErrors('/user/username')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-form-input
        type="password"
        name="password"
        v-model="password"
        :label="$t('users.loginForm.passwordLabel')"
        :error="getErrors('/user/password')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions-block">
      <ly-button type="primary" size="large" submit>
        {{ $t('users.loginForm.submit') }}
      </ly-button>
      <router-link to="/password/reset">{{ $t('users.loginForm.passwordForgotten') }}</router-link>
      <hr />
      <router-link to="/">{{ $t('users.loginForm.register') }}</router-link>
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
        username: '',
        password: '',
      }
    },

    methods: {
      login () {
        this.$store
          .dispatch('users/login', {
            username: this.username,
            password: this.password,
          })
          .then(this.onSuccess)
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
