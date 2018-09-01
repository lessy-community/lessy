<template>
  <router-view v-if="resourcesReady && project" :project="project"></router-view>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  export default {
    props: {
      projectSlug: { type: String, required: true },
    },

    mixins: [ResourcesLoader],

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },

    watch: {
      projectSlug: function (projectSlug) {
        this.$store.commit('projects/setCurrent', projectSlug)
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
