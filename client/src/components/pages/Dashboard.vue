<template>
  <app-content sidebar contentClass="dashboard-page">
    <p v-if="!user.activated" v-html="$t('pages.dashboard.activationInstructions', { email: user.email })"></p>

    <container v-if="inProgressProjects" row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        <div class="badge-container">
          <badge
            v-if="project.tasksCount === 0 || project.tasksCount === project.finishedTasksCount"
            v-tooltip.top="project.tasksCount === 0 ? $t('pages.dashboard.shouldAddTasks') : $t('pages.dashboard.shouldAddMoreTasks')"
            :warn="project.tasksCount === project.finishedTasksCount"
            :alert="project.tasksCount === 0"
          >
            {{ $t('pages.dashboard.tasksCount', { finishedCount: project.finishedTasksCount, totalCount: project.tasksCount }) }}
          </badge>
          <badge v-else>
            {{ $t('pages.dashboard.tasksCount', { finishedCount: project.finishedTasksCount, totalCount: project.tasksCount }) }}
          </badge>
        </div>

        <span v-html="$t('pages.dashboard.dueOn', { date: project.dueAtLabel })" ></span>
        <date-bar-indicator
          :start="project.startedAt"
          :end="project.dueAt"
          :date="today"
          v-tooltip.top="$t('pages.dashboard.datesDescription', { start: project.startedAtLabel, due: project.dueAtLabel })"
        ></date-bar-indicator>
      </card>
    </container>

    <task-list :tasks="tasks"></task-list>

    <template v-if="!createTaskEnabled">
      <btn
        type="primary"
        @click="createTaskEnabled = true"
      >
        <icon name="plus"></icon>
        {{ $t('pages.dashboard.createTask') }}
      </btn>

      {{ $t('pages.dashboard.or') }}

      <router-link to="/tasks/backlog">{{ $t('pages.dashboard.backlog') }}</router-link>
    </template>
    <create-task-form
      v-else
      :plannedAt="plannedAt"
      :onCancel="disableCreateTask"
      autoFocus
    ></create-task-form>
  </app-content>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'
  import CreateTaskForm from '../forms/CreateTask'
  import TaskList from '../tasks/TaskList'
  import DateBarIndicator from '../DateBarIndicator'

  export default {

    name: 'dashboard-page',

    components: {
      CreateTaskForm,
      TaskList,
      DateBarIndicator,
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

    > .badge {
      font-size: 1rem;
    }
  }
</style>
