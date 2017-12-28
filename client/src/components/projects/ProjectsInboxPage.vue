<template>
  <app-page name="projects-inbox">
    <ly-section :title="$t('projects.inboxPage.futureProjects')">
      <ly-button
        icon="plus"
        v-if="!createFormEnabled"
        type="primary"
        @click="createFormEnabled = true"
      >
        {{ $t('projects.inboxPage.createProject') }}
      </ly-button>
      <project-create-form
        v-else
        @cancel="disableCreateForm"
        autofocus
      ></project-create-form>

      <ly-list :placeholder="$t('projects.inboxPage.projectsPlaceholder')">
        <ly-list-group
          v-for="(projects, firstCharacter) in notStartedProjects"
          :name="firstCharacter"
        >
          <ly-list-item v-for="project in projects">
            <ly-list-item-adapt>
              <router-link :to="project.urlShow">
                {{ project.name }}
              </router-link>
            </ly-list-item-adapt>
            <ly-badge v-if="project.isPaused" size="small">
              {{ $t('projects.inboxPage.pausedOn', { date: project.pausedAtLabel }) }}
            </ly-badge>
            <ly-badge v-if="project.tasksCount > 0" size="small">
              {{ $tc('projects.inboxPage.tasksCount', project.tasksCount, {
                finishedCount: project.finishedTasksCount,
                totalCount: project.tasksCount,
              }) }}
            </ly-badge>
          </ly-list-item>
        </ly-list-group>
      </ly-list>
    </ly-section>

    <ly-section v-if="finishedProjects.length > 0" :title="$t('projects.inboxPage.finishedProjects')">
      <ly-list stripped>
        <ly-list-item v-for="project in finishedProjects">
            <ly-list-item-adapt>
              <router-link :to="project.urlShow">
                {{ project.name }}
              </router-link>
            </ly-list-item-adapt>
            <ly-badge size="small">
              {{ $t('projects.inboxPage.finishedLabel', { date: project.finishedAtLabel }) }}
            </ly-badge>
            <ly-badge v-if="project.tasksCount > 0" size="small">
              {{ $tc('projects.inboxPage.tasksCount', project.tasksCount, {
                finishedCount: project.finishedTasksCount,
                totalCount: project.tasksCount,
              }) }}
            </ly-badge>
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
        notStartedProjects: 'projects/listNotStartedByFirstCharacter',
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
