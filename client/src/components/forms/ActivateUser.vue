<template>
  <form @submit.prevent="activate">
    <div v-if="isInError('User')" class="form-errors">
      {{ getErrors('User') }}
    </div>

    <form-group
      :label="$t('forms.activateUser.usernameLabel')"
      target="username"
      required
      :tip="getErrors('User', 'username') || $t('forms.activateUser.usernameTip')"
      :invalid="isInError('User', 'username')"
    >
      <text-field id="username" v-model="username" pattern="[a-z_\-]{1,25}" required />
    </form-group>

    <form-group
      :label="$t('forms.activateUser.passwordLabel')"
      target="password"
      required
      :tip="getErrors('User', 'password')"
      :invalid="isInError('User', 'password')"
    >
      <password-field id="password" v-model="password" required />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.activateUser.submit') }}</btn>
    </form-group>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'activate-user-form',

    mixins: [ErrorsHandler],

    props: {
      'token': { type: String, required: true },
      'onSuccess': { type: Function, required: true },
    },

    data () {
      return {
        username: '',
        password: '',
      }
    },

    methods: {
      activate () {
        this.$store
          .dispatch('users/activate', {
            token: this.token,
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
