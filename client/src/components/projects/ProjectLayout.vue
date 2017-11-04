<template>
  <router-view v-if="project" :project="project"></router-view>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },

    mounted () {
      const { projectName } = this.$route.params
      this.$store.commit('projects/setCurrent', projectName)
    },

    destroyed () {
      this.$store.commit('projects/setCurrent', null)
    },
  }
</script>
