<template>
  <app-page name="projects-inbox">
    <ly-list :placeholder="$t('projects.inboxPage.projectsPlaceholder')">
      <ly-list-item v-for="project in notStartedProjects">
        <router-link :to="project.urlShow">
          {{ project.name }}
          <template v-if="project.isStopped">
            {{ $t('projects.inboxPage.stoppedOn', { date: project.stoppedAtLabel }) }}
          </template>
        </router-link>
      </ly-list-item>
    </ly-list>

    <ly-button
      icon="plus"
      v-if="!createFormEnabled && notStartedProjects.length > 0"
      type="primary"
      @click="createFormEnabled = true"
    >
      {{ $t('projects.inboxPage.createProject') }}
    </ly-button>
    <project-create-form
      v-else
      :onCancel="notStartedProjects.length > 0 && disableCreateForm"
    ></project-create-form>

    <div v-if="numberFinishedProjects > 0" class="projects-finished-section">
      <ly-button v-if="!showFinishedProjects" type="ghost" @click="showFinishedProjects = true">
      {{ $tc('projects.inboxPage.seeFinishedProjects', numberFinishedProjects, { count: numberFinishedProjects }) }}
      </ly-button>
      <ly-button v-else type="ghost" @click="showFinishedProjects = false">
        {{ $tc('projects.inboxPage.hideFinishedProjects', numberFinishedProjects, { count: numberFinishedProjects }) }}
      </ly-button>

      <ly-list>
        <ly-list-item v-if="showFinishedProjects" v-for="project in finishedProjects">
          <router-link :to="project.urlShow">
            {{ project.name }}
            {{ $t('projects.inboxPage.finishedLabel', { date: project.finishedAtLabel }) }}
          </router-link>
        </ly-list-item>
      </ly-list>
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
    },
  }
</script>

<style>
  .projects-finished-section {
    margin-top: 1rem;
  }
</style>
