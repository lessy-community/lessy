<template>
  <ly-form @submit="register" size="small" margined :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="email"
        v-model="email"
        name="email"
        :placeholder="$t('users.registerForm.emailPlaceholder')"
        :label="$t('users.registerForm.emailLabel')"
        :error="getErrors('/user/email')"
        required
      ></ly-form-input>
    </ly-form-group>

    <p v-if="!noTosRequirement">
      {{ $t('users.registerForm.tosMustAccept') }}
      <router-link to="/terms-of-service">{{ $t('users.registerForm.tosLink') }}</router-link>.
    </p>

    <ly-form-group type="actions-block">
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
      'noTosRequirement': { type: Boolean, default: false },
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
