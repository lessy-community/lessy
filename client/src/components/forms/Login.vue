<template>
  <form @submit.prevent="login">
    <div v-if="isInError('User')" class="form-errors">
      {{ getErrors('User') }}
    </div>

    <form-group
      :label="$t('forms.login.usernameLabel')"
      target="username"
      required
      :tip="getErrors('User', 'username')"
      :invalid="isInError('User', 'username')"
    >
      <text-field id="username" v-model="username" pattern="[a-z_\-]{1,}" required />
    </form-group>

    <form-group
      :label="$t('forms.login.passwordLabel')"
      target="password"
      required
      :tip="getErrors('User', 'password')"
      :invalid="isInError('User', 'password')"
    >
      <password-field id="password" v-model="password" required />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.login.submit') }}</btn>
    </form-group>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'login-form',

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

<style lang="scss" scoped>

  .form-errors {
    margin-bottom: 20px;

    text-align: center;

    color: $color-danger;
  }

</style>
