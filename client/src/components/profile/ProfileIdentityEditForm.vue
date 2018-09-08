<template>
  <ly-form @submit="updateUser" :error="getErrors('/user')">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="username"
        v-model="username"
        :label="$t('profile.identityEditForm.usernameLabel')"
        :caption="$t('profile.identityEditForm.usernameCaption')"
        :error="getErrors('/user/username')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-form-input
        type="text"
        name="email"
        v-model="email"
        :label="$t('profile.identityEditForm.emailLabel')"
        :error="getErrors('/user/email')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-button submit>
        {{ $t('profile.identityEditForm.submit') }}
      </ly-button>
      <span :class="['text-success', { show: saved }]">
        <ly-icon name="check"></ly-icon>
        {{ $t('profile.identityEditForm.saved') }}
      </span>
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
        saved: false,
      }
    },

    methods: {
      updateUser () {
        this.cleanErrors()
        this.$store
          .dispatch('users/updateCurrent', {
            username: this.username,
            email: this.email,
          })
          .then(() => {
            this.saved = true
            setTimeout(() => { this.saved = false }, 5000)
          })
          .catch(this.setFailureErrors)
      },
    },
  }
</script>

<style lang="scss" scoped>
  .text-success {
    opacity: 0;

    transition: opacity .2s ease-in-out;

    &.show {
      opacity: 1;
    }
  }
</style>
