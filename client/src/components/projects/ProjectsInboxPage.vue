<template>
  <app-page name="projects-inbox">
    <ly-section :title="$t('projects.inboxPage.futureProjects')">
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
    </ly-section>

    <ly-section v-if="finishedProjects.length > 0" :title="$t('projects.inboxPage.finishedProjects')">
      <ly-list>
        <ly-list-item v-for="project in finishedProjects">
          <router-link :to="project.urlShow">
            {{ project.name }}
            {{ $t('projects.inboxPage.finishedLabel', { date: project.finishedAtLabel }) }}
          </router-link>
        </ly-list-item>
      </ly-list>
    </ly-section>
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
      }
    },

    computed: {
      ...mapGetters({
        notStartedProjects: 'projects/listNotStarted',
        finishedProjects: 'projects/listFinished',
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
      },
    },
  }
</script>
