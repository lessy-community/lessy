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
          <project-item
            v-for="project in projects"
            :key="project"
            :project="project"
          ></project-item>
        </ly-list-group>
      </ly-list>
    </ly-section>

    <ly-section v-if="finishedProjects.length > 0" :title="$t('projects.inboxPage.finishedProjects')">
      <ly-list stripped>
        <project-item-finished
          v-for="project in finishedProjects"
          :key="project.id"
          :project="project"
        ></project-item-finished>
      </ly-list>
    </ly-section>
  </app-page>
</template>

<script>
  import { mapGetters } from 'vuex'
  import ProjectCreateForm from './ProjectCreateForm'
  import ProjectItem from './ProjectItem'
  import ProjectItemFinished from './ProjectItemFinished'

  export default {
    components: {
      ProjectCreateForm,
      ProjectItem,
      ProjectItemFinished,
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
