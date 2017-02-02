<template>
  <app-content v-if="project" sidebar contentClass="project-layout">
    <container row align="center">
      <h1 class="adapt">
        <router-link v-if="project.isInProgress" to="/dashboard">{{ $t('layout.project.dashboard') }}</router-link>
        <router-link v-else to="/projects/inbox">{{ $t('layout.project.projectsInbox') }}</router-link>
        /
        <router-link :to="project.urlShow">{{ project.name }}</router-link>
      </h1>
      <router-link :to="project.urlEdit" class="btn btn-settings">{{ $t('layout.project.settings') }}</router-link>
    </container>
    <router-view v-if="project" :project="project"></router-view>
  </app-content>
  <error-page v-else-if="error" :message="error"></error-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ErrorPage from '../pages/Error'
  import LoadingPage from '../pages/Loading'

  export default {

    name: 'project-layout',

    components: {
      ErrorPage,
      LoadingPage,
    },

    data () {
      return {
        error: null,
      }
    },

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },

    mounted () {
      const { userIdentifier, projectName } = this.$route.params
      this.$store
        .dispatch('projects/find', { userIdentifier, projectName })
        .catch((error) => {
          this.error = error.data.message
        })
    },

    destroyed () {
      this.$store.commit('projects/resetCurrent')
    },

  }
</script>

<style scoped>

  .btn-settings.router-link-active {
    color: #666;
  }
  .btn-settings.router-link-active:hover {
    text-decoration: none;
  }

</style>
