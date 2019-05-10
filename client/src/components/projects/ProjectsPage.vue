<template>
  <app-page v-if="resourcesReady" name="projects" layout="application">
    <projects-header slot="header"></projects-header>

    <ly-section
      v-if="projectsInProgress.length > 0"
      :title="$t('projects.page.projectsInProgress')"
    >
      <ly-list>
        <project-item
          v-for="project in projectsInProgress"
          :key="project.id"
          :project="project"
        ></project-item>
      </ly-list>
    </ly-section>

    <ly-section :title="$t('projects.page.futureProjects')">
      <ly-button
        icon="plus"
        v-if="!createFormEnabled"
        type="primary"
        @click="createFormEnabled = true"
      >
        {{ $t('projects.page.createProject') }}
      </ly-button>
      <project-create-form
        v-else
        @cancel="disableCreateForm"
        autofocus
      ></project-create-form>

      <ly-list :placeholder="$t('projects.page.projectsPlaceholder')">
        <ly-list-group
          v-for="(projects, firstCharacter) in futureProjects"
          :key="firstCharacter"
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

    <ly-section v-if="finishedProjects.length > 0" :title="$t('projects.page.finishedProjects')">
      <ly-list stripped>
        <project-item-finished
          v-for="project in finishedProjects"
          :key="project.id"
          :project="project"
        ></project-item-finished>
      </ly-list>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from '@/components/mixins/ResourcesLoader'

  import ProjectsHeader from './ProjectsHeader'
  import ProjectCreateForm from './ProjectCreateForm'
  import ProjectItem from './ProjectItem'
  import ProjectItemFinished from './ProjectItemFinished'

  export default {
    mixins: [ResourcesLoader],

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
        projectsInProgress: 'projects/listInProgress',
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
      },
    },
  }
</script>
