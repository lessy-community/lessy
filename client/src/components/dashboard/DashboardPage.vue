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

    <ly-section :title="$t('dashboard.page.tasksHistory')">
      <tasks-chart
        :days="days()"
        :createdByDays="createdTasksByDays"
        :finishedByDays="finishedTasksByDays"
        :selected="selectedDay"
      ></tasks-chart>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import initialMoment from 'moment'
  import { extendMoment } from 'moment-range'

  import { mapGetters } from 'vuex'

  import ResourcesLoader from '@/components/mixins/ResourcesLoader'

  import UserPopover from '@/components/users/UserPopover'
  import ProjectCardDeck from '@/components/projects/ProjectCardDeck'
  import TasksChart from '@/components/tasks/TasksChart'

  const moment = extendMoment(initialMoment)

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TasksChart,
      ProjectCardDeck,
    },

    data () {
      return {
        selectedDay: moment(),
        activationEmailResent: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        projects: 'projects/listInProgress',
        finishedTasksByDays: 'tasks/listFinishedByDays',
        createdTasksByDays: 'tasks/listCreatedByDays',
      }),
    },

    methods: {
      resendActivationEmail () {
        this.$store
          .dispatch('users/resendActivationEmail', { email: this.user.email })
          .then(() => { this.activationEmailResent = true })
      },

      days () {
        const lastWeek = moment().subtract(2, 'weeks')
        const today = moment()
        const period = moment.range(lastWeek, today)
        const days = Array.from(period.by('day'))
        return days
      },
    },
  }
</script>
