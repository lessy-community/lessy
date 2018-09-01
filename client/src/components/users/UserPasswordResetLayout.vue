<template>
  <app-layout name="user-password-reset" no-tos-requirement>
    <welcome-header slot="header"></welcome-header>
    <app-page name="user-password-reset">
      <div class="app-page-user-password-reset-container">
        <h1>{{ $t('users.passwordResetLayout.title') }}</h1>

        <template v-if="sentTo">
          <p>
            {{ $t('users.passwordResetLayout.emailSentTo', { email: sentTo }) }}
          </p>
          <router-link to="/login">{{ $t('users.passwordResetLayout.login') }}</router-link>
        </template>

        <template v-else-if="emailToActivate">
          <p>{{ $t('users.passwordResetLayout.accountInactive') }}</p>
          <ly-button
            v-if="!activationEmailResent"
            icon="envelope-o"
            @click="resendActivationEmail"
          >
            {{ $t('users.passwordResetLayout.resendActivationInstructions') }}
          </ly-button>
          <p v-else class="text-success">
            <ly-icon name="check"></ly-icon>
            {{ $t('users.passwordResetLayout.resendActivationInstructionsDone') }}
          </p>
        </template>

        <template v-else>
          <p>{{ $t('users.passwordResetLayout.emailIntro') }}</p>
          <user-password-reset-form
            @success="onFormSuccess"
            @fail="onFormFail"
          ></user-password-reset-form>
        </template>
      </div>
    </app-page>
  </app-layout>
</template>

<script>
  import WelcomeHeader from 'src/components/general/WelcomeHeader'
  import UserPasswordResetForm from './UserPasswordResetForm'

  export default {
    components: {
      WelcomeHeader,
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

<style lang="scss">
  .app-page-user-password-reset {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);

    h1 {
      text-align: center;
    }
  }

  .app-page-user-password-reset-container {
    max-width: 30rem;
    margin-left: auto;
    margin-right: auto;
  }
</style>
