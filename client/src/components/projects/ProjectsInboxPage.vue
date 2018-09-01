<template>
  <app-page name="projects-inbox" layout="application">
    <projects-header slot="header"></projects-header>

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
          v-for="(projects, firstCharacter) in futureProjects"
          :name="firstCharacter"
        >
          <project-item
            v-for="project in projects"
            :key="project.id"
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

  import ProjectsHeader from './ProjectsHeader'
  import ProjectCreateForm from './ProjectCreateForm'
  import ProjectItem from './ProjectItem'
  import ProjectItemFinished from './ProjectItemFinished'

  export default {
    components: {
      ProjectsHeader,
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
        futureProjects: 'projects/listFutureByFirstCharacter',
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
