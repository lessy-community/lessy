<template>
  <app-page name="project-show" layout="application">
    <projects-header slot="header"></projects-header>

    <ly-section :title="project.name">
      <ly-button
        icon="pencil"
        @click="editDescription"
      >
        {{ $t('projects.showPage.edit') }}
      </ly-button>

      <ly-button
        type="ghost"
        icon="trash"
        @click="activeModal = 'delete'"
      >
        {{ $t('projects.showPage.delete') }}
      </ly-button>

      <ly-columns bordered>
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
          <task-list
            :tasks="todoTasks"
            notoggle
            hide-project-badge
          ></task-list>

          <template v-if="finishedTasks.length > 0">
            <h3>{{ $t('projects.showPage.finishedTasks') }}</h3>
            <task-list
              :tasks="finishedTasks"
              nodraggable
              notoggle
              hide-project-badge
            ></task-list>
          </template>
        </ly-column>
      </ly-columns>
    </ly-section>

    <project-delete-modal
      v-if="activeModal === 'delete'"
      :project="project"
      @close="activeModal = null"
    ></project-delete-modal>
  </app-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ProjectsHeader from './ProjectsHeader'
  import ProjectTimeline from './ProjectTimeline'
  import ProjectDeleteModal from './ProjectDeleteModal'
  import TaskCreateForm from '@/components/tasks/TaskCreateForm'
  import TaskList from '@/components/tasks/TaskList'

  export default {
    components: {
      ProjectsHeader,
      ProjectTimeline,
      ProjectDeleteModal,
      TaskCreateForm,
      TaskList,
    },

    props: {
      'project': { type: Object, required: true },
    },

    data () {
      return {
        activeModal: null,
      }
    },

    computed: {
      ...mapGetters({
        todoTasks: 'tasks/listTodoForCurrentProject',
        finishedTasks: 'tasks/listFinishedForCurrentProject',
      }),
    },

    methods: {
      editDescription () {
        this.$router.push(this.project.urlEdit)
      }
    },
  }
</script>
