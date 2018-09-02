<template>
  <ly-form>
    <ly-card>
      <p>
        {{ $t('profile.editForm.disabled') }}
      </p>
    </ly-card>

    <ly-form-group>
      <ly-form-input
        type="text"
        name="username"
        v-model="username"
        :label="$t('profile.editForm.usernameLabel')"
        :error="getErrors('/user/username')"
        required
        disabled
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-form-input
        type="text"
        name="email"
        v-model="email"
        :label="$t('profile.editForm.emailLabel')"
        :error="getErrors('/user/email')"
        required
        disabled
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-form-input
        type="password"
        name="password"
        v-model="password"
        :label="$t('profile.editForm.passwordLabel')"
        :error="getErrors('/user/password')"
        disabled
      ></ly-form-input>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      user: { type: Object, required: true },
    },

    data () {
      return {
        username: this.user.username,
        email: this.user.email,
        password: '',
      }
    },
  }
</script>
