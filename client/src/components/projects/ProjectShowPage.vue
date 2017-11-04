<template>
  <app-page name="project-show">
    <h2>{{ project.name }}</h2>

    <router-link :to="project.urlEdit">
      {{ $t('projects.showPage.settings') }}
    </router-link>

    <container row align="center">
      <div v-if="project.isStarted">
        <form-group :label="$t('projects.showPage.startedLabel')">
          <static-field :value="project.startedAtLabel" />
        </form-group>
        <form-group v-if="project.isFinished" :label="$t('projects.showPage.finishedLabel')">
          <static-field :value="project.finishedAtLabel" />
        </form-group>
        <form-group v-else :label="$t('projects.showPage.dueLabel')">
          <static-field :value="project.dueAtLabel" />
        </form-group>
      </div>
      <div v-else-if="project.isStopped">
        <form-group :label="$t('projects.showPage.stoppedLabel')">
          <static-field :value="project.stoppedAtLabel" />
        </form-group>
      </div>

      <div v-if="!project.isStarted" class="project-actions adapt">
        <router-link
          v-if="canStartProject"
          :to="project.urlStart"
        >
          {{ $t('projects.showPage.startProject') }}
        </router-link>
      </div>
      <div v-else-if="!project.isFinished" class="project-actions adapt">
        <router-link :to="project.urlFinish">
          {{ $t('projects.showPage.finishProject') }}
        </router-link>
        <ly-button @click="confirmStop">
          {{ $t('projects.showPage.stopProject') }}
        </ly-button>
      </div>
    </container>

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

  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskList from 'src/components/tasks/TaskList'

  export default {
    components: {
      TaskCreateForm,
      TaskList,
    },

    props: {
      'project': { type: Object, required: true },
    },

    computed: {
      ...mapGetters({
        canStartProject: 'projects/canStartProject',
        tasks: 'tasks/listForCurrentProject',
      }),
    },

    methods: {
      confirmStop () {
        if (window.confirm(this.$t('projects.showPage.confirmStop'))) {
          this.$store.dispatch('projects/stop', { project: this.project })
        }
      },
    },
  }
</script>

<style scoped>
  .project-actions {
    padding-top: .25rem;
    padding-bottom: .25rem;

    text-align: center;
  }

  .project-description {
    font-size: 1.1rem;
  }
</style>
