<template>
  <div v-if="project" class="project-layout">
    <h1>
      <router-link :to="project.user.urlShow">{{ project.user.displayedName }}</router-link>
      / {{ project.name }}
    </h1>
    <router-view v-if="project" :project="project"></router-view>
  </div>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'
  import LoadingPage from '../pages/Loading'

  export default {

    name: 'project-layout',

    components: {
      LoadingPage,
    },

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },

    mounted () {
      const { userIdentifier, projectName } = this.$route.params
      this.$store.dispatch('projects/find', { userIdentifier, projectName })
    },

    destroyed () {
      this.$store.commit('projects/resetCurrent')
    },

  }
</script>
