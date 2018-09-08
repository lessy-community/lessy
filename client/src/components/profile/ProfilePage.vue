<template>
  <app-page v-if="resourcesReady" name="profile" layout="profile">
    <ly-section :title="$t('profile.page.identity')">
      <profile-identity-edit-form :user="user">
      </profile-identity-edit-form>
    </ly-section>

    <ly-section :title="$t('profile.page.password')">
      <profile-password-new-form>
      </profile-password-new-form>
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

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import ProfileIdentityEditForm from './ProfileIdentityEditForm'
  import ProfilePasswordNewForm from './ProfilePasswordNewForm'
  import ProfileDeleteAccount from './ProfileDeleteAccount'

  export default {
    mixins: [ResourcesLoader],

    components: {
      ProfileIdentityEditForm,
      ProfilePasswordNewForm,
      ProfileDeleteAccount,
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },
  }
</script>
