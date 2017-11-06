<template>
  <app-page name="dashboard">
    <p v-if="!user.activated" v-html="$t('dashboard.page.activationInstructions', { email: user.email })"></p>

    <ly-card-deck v-if="inProgressProjects">
      <ly-card v-for="project in inProgressProjects">
        <h3><router-link :to="project.urlShow">{{ project.name }}</router-link></h3>
        <div class="badge-container">
          <ly-badge
            v-if="project.tasksCount === 0 || project.tasksCount === project.finishedTasksCount"
            v-tooltip.top="project.tasksCount === 0 ? $t('dashboard.page.shouldAddTasks') : $t('dashboard.page.shouldAddMoreTasks')"
            :type="project.tasksCount === 0 ? 'alert' : 'warning'"
          >
            {{ $t('dashboard.page.tasksCount', { finishedCount: project.finishedTasksCount, totalCount: project.tasksCount }) }}
          </ly-badge>
          <ly-badge v-else>
            {{ $t('dashboard.page.tasksCount', { finishedCount: project.finishedTasksCount, totalCount: project.tasksCount }) }}
          </ly-badge>
        </div>

        <span v-html="$t('dashboard.page.dueOn', { date: project.dueAtLabel })" ></span>
        <project-date-indicator
          :start="project.startedAt"
          :end="project.dueAt"
          :date="today"
          v-tooltip.top="$t('dashboard.page.datesDescription', { start: project.startedAtLabel, due: project.dueAtLabel })"
        ></project-date-indicator>
      </ly-card>
    </ly-card-deck>

    <task-list :tasks="tasks"></task-list>

    <template v-if="!createTaskEnabled">
      <ly-button
        icon="plus"
        type="primary"
        @click="createTaskEnabled = true"
      >
        {{ $t('dashboard.page.createTask') }}
      </ly-button>

      {{ $t('dashboard.page.or') }}

      <router-link to="/tasks/backlog">{{ $t('dashboard.page.backlog') }}</router-link>
    </template>
    <task-create-form
      v-else
      :plannedAt="plannedAt"
      :onCancel="disableCreateTask"
      autoFocus
    ></task-create-form>
  </app-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'
  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskList from 'src/components/tasks/TaskList'
  import ProjectDateIndicator from 'src/components/projects/ProjectDateIndicator'

  export default {
    components: {
      TaskCreateForm,
      TaskList,
      ProjectDateIndicator,
    },

    data () {
      return {
        createTaskEnabled: false,
        plannedAt: moment().endOf('day'),
        today: moment().unix(),
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        inProgressProjects: 'projects/listInProgress',
        tasks: 'tasks/listForToday',
      }),
    },

    methods: {
      disableCreateTask () {
        this.createTaskEnabled = false
      },
    },
  }
</script>

<style lang="scss" scoped>
  .badge-container {
    margin-top: -5px;
    margin-bottom: 10px;

    text-align: center;
  }
</style>
