<template>
  <div v-if="project" class="project-show-page">
    <h1>{{ project.name }}</h1>
    <p v-if="project.description">
      {{ project.description }}
    </p>
    <p v-else>
      <em>Aucune description</em>
    </p>
  </div>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'
  import LoadingPage from '../Loading'

  export default {

    name: 'project-show-page',

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
