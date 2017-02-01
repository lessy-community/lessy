<template>
  <div class="projects-inbox-page">
    <div>
      <list-item v-for="project in notStartedProjects">
        <router-link :to="project.urlShow">
          {{ project.name }}
          <template v-if="project.isStopped">
            {{ $t('pages.projects.inbox.stoppedOn', { date: project.stoppedAtLabel }) }}
          </template>
        </router-link>
      </list-item>
      <div v-if="!notStartedProjects" class="new-project-placeholder">
        <p>{{ $t('pages.projects.inbox.projectsPlaceholder') }}</p>
        <create-project-form :onSuccess="redirectToStartProject"></create-project-form>
      </div>

      <btn
        v-if="!createFormEnabled"
        type="primary"
        @click="createFormEnabled = true"
      >
        {{ $t('pages.projects.inbox.createProject') }}
      </btn>
      <create-project-form v-else :onCancel="disableCreateForm"></create-project-form>
    </div>

    <div v-if="numberFinishedProjects > 0" class="projects-finished">
      <btn v-if="!showFinishedProjects" type="secondary" @click="loadFinishedProjects">
      {{ $tc('pages.projects.inbox.seeFinishedProjects', numberFinishedProjects, { count: numberFinishedProjects }) }}
      </btn>
      <btn v-else type="secondary" @click="showFinishedProjects = false">
        {{ $tc('pages.projects.inbox.hideFinishedProjects', numberFinishedProjects, { count: numberFinishedProjects }) }}
      </btn>

      <list-item v-if="showFinishedProjects" v-for="project in finishedProjects">
        <router-link :to="project.urlShow">
          {{ project.name }}
          {{ $t('pages.projects.inbox.finishedLabel', { date: project.finishedAtLabel }) }}
        </router-link>
      </list-item>
    </div>
  </div>
</template>

<script>
  import { mapGetters, mapState } from 'vuex'
  import CreateProjectForm from '../../forms/CreateProject'

  export default {

    name: 'projects-inbox-page',

    components: {
      CreateProjectForm,
    },

    data () {
      return {
        createFormEnabled: false,
        showFinishedProjects: false,
      }
    },

    computed: {
      ...mapGetters({
        notStartedProjects: 'projects/listNotStarted',
        finishedProjects: 'projects/listFinished',
        numberCurrentProjects: 'projects/numberCurrent',
      }),
      ...mapState({
        numberFinishedProjects: state => state.projects.numberFinished,
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
      },

      loadFinishedProjects () {
        const { dispatch, getters } = this.$store
        dispatch('projects/getFinished', {
          userIdentifier: getters['users/current'].identifier,
        }).then(() => { this.showFinishedProjects = true })
      },

      redirectToStartProject (projectId) {
        const project = this.$store.getters['projects/findById'](projectId)
        this.$router.push(project.urlStart)
      },
    },

  }
</script>

<style>

  .projects-inbox-page .list-item:last-of-type {
    margin-bottom: 10px;
  }

  .projects-inbox-page .projects-finished {
    margin-top: 30px;
  }

  .projects-inbox-page .new-project-placeholder {
    text-align: center;
  }
  .projects-inbox-page .new-project-placeholder p {
    font-size: 1.2rem;
    line-height: 2.5rem;
  }

  .projects-inbox-page .new-project-placeholder form {
    width: 500px;
    margin-left: auto;
    margin-right: auto;
  }
  .projects-inbox-page .new-project-placeholder .form-group-tip {
    text-align: left;
  }

</style>
