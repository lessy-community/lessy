<template>
  <ly-form @submit="activate" :error="getErrors('/user')">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="username"
        v-model="username"
        pattern="[a-z_\-]{1,25}"
        :label="$t('users.activateForm.usernameLabel')"
        :caption="$t('users.activateForm.usernameCaption')"
        :error="getErrors('/user/username')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-form-input
        type="password"
        name="password"
        v-model="password"
        :label="$t('users.activateForm.passwordLabel')"
        :error="getErrors('/user/password')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" size="large" submit>{{ $t('users.activateForm.submit') }}</ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
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
