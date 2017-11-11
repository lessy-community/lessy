<template>
  <app-page name="project-show">
    <h2>{{ project.name }}</h2>

    <router-link :to="project.urlEdit">
      {{ $t('projects.showPage.settings') }}
    </router-link>

    <project-timeline :project="project"></project-timeline>

    <ly-text-container v-if="project.description" class="project-description text-container" v-html="project.mdDescription"></ly-text-container>
    <p v-else>
      <em>
        {{ $t('projects.showPage.noDescription') }}
        <router-link :to="project.urlEdit">
          {{ $t('projects.showPage.askEdit') }}
        </router-link>
      </em>
    </p>

    <h2>Associated tasks</h2>
    <task-list :tasks="tasks" notoggle hide-project-badge></task-list>
    <task-create-form :project-id="project.id"></task-create-form>
  </app-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ProjectTimeline from './ProjectTimeline'
  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskList from 'src/components/tasks/TaskList'

  export default {
    components: {
      ProjectTimeline,
      TaskCreateForm,
      TaskList,
    },

    props: {
      'project': { type: Object, required: true },
    },

    computed: {
      ...mapGetters({
        tasks: 'tasks/listForCurrentProject',
      }),
    },
  }
</script>
