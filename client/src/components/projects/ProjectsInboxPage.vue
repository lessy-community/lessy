<template>
  <app-page name="projects-inbox">
    <div>
      <list-item v-for="project in notStartedProjects" @click="$router.push(project.urlShow)">
        {{ project.name }}
        <template v-if="project.isStopped">
          {{ $t('projects.inboxPage.stoppedOn', { date: project.stoppedAtLabel }) }}
        </template>
      </list-item>
      <div v-if="!notStartedProjects" class="new-project-placeholder">
        <p>{{ $t('projects.inboxPage.projectsPlaceholder') }}</p>
        <project-create-form :onSuccess="redirectToStartProject"></project-create-form>
      </div>

      <ly-button
        icon="plus"
        v-if="!createFormEnabled"
        type="primary"
        @click="createFormEnabled = true"
      >
        {{ $t('projects.inboxPage.createProject') }}
      </ly-button>
      <project-create-form v-else :onCancel="disableCreateForm"></project-create-form>
    </div>

    <div v-if="numberFinishedProjects > 0" class="projects-finished">
      <ly-button v-if="!showFinishedProjects" @click="showFinishedProjects = true">
      {{ $tc('projects.inboxPage.seeFinishedProjects', numberFinishedProjects, { count: numberFinishedProjects }) }}
      </ly-button>
      <ly-button v-else @click="showFinishedProjects = false">
        {{ $tc('projects.inboxPage.hideFinishedProjects', numberFinishedProjects, { count: numberFinishedProjects }) }}
      </ly-button>

      <list-item v-if="showFinishedProjects" v-for="project in finishedProjects" @click="$router.push(project.urlShow)">
        {{ project.name }}
        {{ $t('projects.inboxPage.finishedLabel', { date: project.finishedAtLabel }) }}
      </list-item>
    </div>
  </app-page>
</template>

<script>
  import { mapGetters } from 'vuex'
  import ProjectCreateForm from './ProjectCreateForm'

  export default {
    components: {
      ProjectCreateForm,
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
        numberFinishedProjects: 'projects/numberFinished',
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
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
