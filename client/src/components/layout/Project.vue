<template>
  <div v-if="project" class="project-layout">
    <container row align="center">
      <h1 class="adapt">
        <router-link :to="project.user.urlShow">{{ project.user.displayedName }}</router-link>
        /
        <router-link :to="project.urlShow">{{ project.name }}</router-link>
      </h1>
      <router-link :to="project.urlEdit" class="btn btn-settings">{{ $t('layout.project.settings') }}</router-link>
    </container>
    <router-view v-if="project" :project="project"></router-view>
  </div>
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

  .project-layout .container > h1 {
    margin-left: -5px;
  }

  .btn-settings.router-link-active {
    color: #666;
  }
  .btn-settings.router-link-active:hover {
    text-decoration: none;
  }

</style>
