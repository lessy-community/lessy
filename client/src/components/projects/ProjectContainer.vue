<template>
  <router-view v-if="resourcesReady && project" :project="project"></router-view>
  <not-found-page v-else-if="resourcesReady && !project"></not-found-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import NotFoundPage from 'src/components/general/NotFoundPage'

  export default {
    props: {
      projectSlug: { type: String, required: true },
    },

    mixins: [ResourcesLoader],

    components: {
      NotFoundPage,
    },

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },

    watch: {
      projectSlug: function (projectSlug) {
        this.$store.commit('projects/setCurrent', projectSlug)
      },

      resourcesReady: function (ready) {
        if (ready) {
          this.$store.commit('projects/setCurrent', this.projectSlug)
        }
      },
    },

    mounted () {
      this.$store.commit('projects/setCurrent', this.projectSlug)
    },

    destroyed () {
      this.$store.commit('projects/setCurrent', null)
    },
  }
</script>
