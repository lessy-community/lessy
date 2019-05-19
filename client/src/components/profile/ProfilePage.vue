<template>
  <app-page v-if="resourcesReady" name="profile" layout="profile">
    <ly-text-container v-if="!user.activated">
      <ly-card>
        <p v-html="$t('profile.page.activationInstructions', { email: user.email })"></p>
        <ly-button
          v-if="!activationEmailResent"
          icon="envelope-o"
          @click="resendActivationEmail"
        >
          {{ $t('profile.page.resendActivationInstructions') }}
        </ly-button>
        <p v-else class="text-success">
          <ly-icon name="check"></ly-icon>
          {{ $t('profile.page.resendActivationInstructionsDone') }}
        </p>
      </ly-card>
    </ly-text-container>
    <template v-else>
      <ly-section :title="$t('profile.page.identity')">
        <profile-identity-edit-form :user="user">
        </profile-identity-edit-form>
      </ly-section>

      <ly-section :title="$t('profile.page.password')">
        <profile-password-new-form>
        </profile-password-new-form>
      </ly-section>

      <ly-section :title="$t('profile.page.timeZone')">
        <profile-time-zone-form :user="user">
        </profile-time-zone-form>
      </ly-section>
    </template>

    <ly-section :title="$t('profile.page.language')">
      <profile-language-form>
      </profile-language-form>
    </ly-section>

    <ly-section :title="$t('profile.page.account')">
      <profile-delete-account>
      </profile-delete-account>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from '@/components/mixins/ResourcesLoader'

  import ProfileIdentityEditForm from './ProfileIdentityEditForm'
  import ProfilePasswordNewForm from './ProfilePasswordNewForm'
  import ProfileTimeZoneForm from './ProfileTimeZoneForm'
  import ProfileLanguageForm from './ProfileLanguageForm'
  import ProfileDeleteAccount from './ProfileDeleteAccount'

  export default {
    mixins: [ResourcesLoader],

    components: {
      ProfileIdentityEditForm,
      ProfilePasswordNewForm,
      ProfileTimeZoneForm,
      ProfileLanguageForm,
      ProfileDeleteAccount,
    },

    data () {
      return {
        activationEmailResent: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },

    methods: {
      resendActivationEmail () {
        this.$store
          .dispatch('users/resendActivationEmail', { email: this.user.email })
          .then(() => { this.activationEmailResent = true })
      },
    },
  }
</script>
