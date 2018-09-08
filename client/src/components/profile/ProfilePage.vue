<template>
  <app-page v-if="resourcesReady" name="profile" layout="profile">
    <ly-section :title="$t('profile.page.identity')">
      <profile-identity-edit-form :user="user">
      </profile-identity-edit-form>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import ProfileIdentityEditForm from './ProfileIdentityEditForm'

  export default {
    mixins: [ResourcesLoader],

    components: {
      ProfileIdentityEditForm,
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },
  }
</script>
