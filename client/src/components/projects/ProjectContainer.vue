<template>
  <router-view v-if="project" :project="project"></router-view>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: {
      projectSlug: { type: String, required: true },
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
    },

    mounted () {
      this.$store.commit('projects/setCurrent', this.projectSlug)
    },

    destroyed () {
      this.$store.commit('projects/setCurrent', null)
    },
  }
</script>
