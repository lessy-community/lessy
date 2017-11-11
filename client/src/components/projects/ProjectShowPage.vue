<template>
  <app-page name="project-show">
    <ly-section :title="project.name">
      <ly-button
        icon="pencil"
        @click="editDescription"
      >
        {{ $t('projects.showPage.edit') }}
      </ly-button>

      <ly-columns>
        <ly-column>
          <h3>Notes</h3>

          <ly-text-container v-if="project.description" class="project-description text-container" v-html="project.mdDescription"></ly-text-container>
          <p v-else class="text-secondary">
            {{ $t('projects.showPage.noDescription') }}
          </p>
        </ly-column>

        <ly-column>
          <h3>{{ $t('projects.showPage.timeline') }}</h3>
          <project-timeline :project="project"></project-timeline>

          <h3>{{ $t('projects.showPage.associatedTasks') }}</h3>
          <task-create-form :project-id="project.id"></task-create-form>
          <task-list :tasks="tasks" notoggle hide-project-badge></task-list>
        </ly-column>
      </ly-columns>
    </ly-section>
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

    methods: {
      editDescription () {
        this.$router.push(this.project.urlEdit)
      }
    },
  }
</script>
