<template>
  <app-page v-if="resourcesReady" name="profile" layout="profile">
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  export default {
    mixins: [ResourcesLoader],

    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },
  }
</script>
