<template>
  <app-page v-if="resourcesReady" name="dashboard" layout="application">
    <app-header :title="$t('dashboard.page.title')" fluid slot="header">
      <user-popover slot="right">
      </user-popover>
    </app-header>

    <ly-card v-if="!user.activated">
      <p v-html="$t('dashboard.page.activationInstructions', { email: user.email })"></p>
      <ly-button
        v-if="!activationEmailResent"
        icon="envelope-o"
        @click="resendActivationEmail"
      >
        {{ $t('dashboard.page.resendActivationInstructions') }}
      </ly-button>
      <p v-else class="text-success">
        <ly-icon name="check"></ly-icon>
        {{ $t('dashboard.page.resendActivationInstructionsDone') }}
      </p>
    </ly-card>

    <ly-section :title="$t('dashboard.page.projectsInProgress')">
      <project-card-deck :projects="projects"></project-card-deck>
    </ly-section>

    <ly-section
      v-if="todayFeatureEnabled"
      :title="$t('dashboard.page.statsChart')"
    >
      <line-chart :data="chartData()"></line-chart>
    </ly-section>
    <ly-section
      v-else
      :title="$tc('dashboard.page.tasksForToday', tasks.length, { count: tasks.length })"
    >
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
        :onCancel="() => { this.createTaskEnabled = false }"
        autoFocus
      ></task-create-form>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import UserPopover from 'src/components/users/UserPopover'

  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskList from 'src/components/tasks/TaskList'
  import LineChart from 'src/components/tasks/LineChart'
  import ProjectCardDeck from 'src/components/projects/ProjectCardDeck'

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TaskCreateForm,
      TaskList,
      LineChart,
      ProjectCardDeck,
    },

    data () {
      return {
        createTaskEnabled: false,
        plannedAt: moment().endOf('day'),
        activationEmailResent: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        todayFeatureEnabled: 'features/todayEnabled',
        projects: 'projects/listInProgress',
        tasks: 'tasks/listForToday',
        countFinishedTasksByDays: 'tasks/countFinishedByDays',
        countCreatedTasksByDays: 'tasks/countCreatedByDays',
      }),
    },

    methods: {
      resendActivationEmail () {
        this.$store
          .dispatch('users/resendActivationEmail', { email: this.user.email })
          .then(() => { this.activationEmailResent = true })
      },

      chartData () {
        const lastWeek = moment().subtract(2, 'weeks')
        const today = moment()
        const period = moment.range(lastWeek, today)
        const days = Array.from(period.by('day'))

        return {
          labels: days.map(date => this.$d(date.toDate(), 'abbr')),
          datasets: [
            {
              label: this.$t('dashboard.page.createdTasks'),
              backgroundColor: '#0080b0',
              borderColor: '#0080b0',
              pointBorderColor: '#fff',
              pointRadius: 6,
              pointBorderWidth: 3,
              fill: false,
              lineTension: 0,
              data: days.map(date => this.countCreatedTasksByDays[date.format('YYYY-MM-DD')] || 0),
            },
            {
              label: this.$t('dashboard.page.finishedTasks'),
              backgroundColor: '#5cb860',
              borderColor: '#5cb860',
              pointBorderColor: '#fff',
              pointRadius: 6,
              pointBorderWidth: 3,
              fill: false,
              lineTension: 0,
              data: days.map(date => this.countFinishedTasksByDays[date.format('YYYY-MM-DD')] || 0),
            },
          ],
        }
      },
    },
  }
</script>
