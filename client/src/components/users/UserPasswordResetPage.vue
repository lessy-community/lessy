<template>
  <app-page name="user-password-reset" layout="single-form">
    <h1>{{ $t('users.passwordResetPage.title') }}</h1>

    <template v-if="sentTo">
      <p>
        {{ $t('users.passwordResetPage.emailSentTo', { email: sentTo }) }}
      </p>
      <router-link to="/login">{{ $t('users.passwordResetPage.login') }}</router-link>
    </template>

    <template v-else-if="emailToActivate">
      <p>{{ $t('users.passwordResetPage.accountInactive') }}</p>
      <ly-button
        v-if="!activationEmailResent"
        icon="envelope-o"
        @click="resendActivationEmail"
      >
        {{ $t('users.passwordResetPage.resendActivationInstructions') }}
      </ly-button>
      <p v-else class="text-success">
        <ly-icon name="check"></ly-icon>
        {{ $t('users.passwordResetPage.resendActivationInstructionsDone') }}
      </p>
    </template>

    <template v-else>
      <p>{{ $t('users.passwordResetPage.emailIntro') }}</p>
      <user-password-reset-form
        @success="onFormSuccess"
        @fail="onFormFail"
      ></user-password-reset-form>
    </template>
  </app-page>
</template>

<script>
  import UserPasswordResetForm from './UserPasswordResetForm'

  export default {
    components: {
      UserPasswordResetForm,
    },

    data () {
      return {
        sentTo: null,
        emailToActivate: null,
        activationEmailResent: false,
      }
    },

    methods: {
      onFormSuccess (email) {
        this.sentTo = email
      },

      onFormFail ({ errors, email }) {
        const isUserInactive = errors.some((error) => error.code === 'user_inactive')
        if (isUserInactive) {
          this.emailToActivate = email
        }
      },

      resendActivationEmail () {
        this.$store
          .dispatch('users/resendActivationEmail', {
            email: this.emailToActivate,
          })
          .then(() => { this.activationEmailResent = true })
      },
    },
  }
</script>
