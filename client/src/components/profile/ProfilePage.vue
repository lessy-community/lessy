<template>
  <app-page v-if="resourcesReady" name="profile" layout="profile">
    <profile-edit-form :user="user">
    </profile-edit-form>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import ProfileEditForm from './ProfileEditForm'

  export default {
    mixins: [ResourcesLoader],

    components: {
      ProfileEditForm,
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },
  }
</script>
