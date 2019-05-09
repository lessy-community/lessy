<template>
  <app-page
    v-if="resourcesReady"
    name="today"
    layout="application"
    :centered="centered"
  >
    <app-header :title="$t('today.page.title')" fluid slot="header">
      <user-popover slot="right">
      </user-popover>
    </app-header>

    <div v-if="mode === 'planner' && this.isTaskPlanned && endOfDay" class="complete-day">
      <ly-button
        type="primary"
        icon="check"
        size="large"
        @click="mode = 'completeDay'"
      >
        {{ $t('today.page.finishDay') }}
      </ly-button>
    </div>

    <div v-if="mode === 'dayCompleted'" class="day-completed">
      <ly-icon name="star" size="large"></ly-icon>

      <p class="text-secondary">
        {{ $t('today.page.dayCompleted') }}
      </p>
    </div>

    <tasks-complete-day
      v-else-if="mode === 'completeDay'"
      :unfinishedCount="todoTasks.length"
      :finishedTasks="finishedTasks"
      @complete="completeDay"
      @cancel="mode = 'planner'"
    >
    </tasks-complete-day>

    <tasks-planner
      v-else-if="mode === 'planner'"
      :todoTasks="todoTasks"
      :finishedTasks="finishedTasks"
    ></tasks-planner>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import ResourcesLoader from '@/components/mixins/ResourcesLoader'

  import UserPopover from '@/components/users/UserPopover'
  import TasksPlanner from '@/components/tasks/TasksPlanner'
  import TasksCompleteDay from '@/components/tasks/TasksCompleteDay'

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TasksPlanner,
      TasksCompleteDay,
    },

    data () {
      return {
        mode: this.isDayCompleted() ? 'dayCompleted' : 'planner',
        endOfDay: this.isEndOfDay(),
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        todoTasks: 'tasks/listTodoForToday',
        finishedTasks: 'tasks/listFinishedToday',
      }),

      isTaskPlanned () {
        return (this.todoTasks.length + this.finishedTasks.length) > 0
      },

      centered () {
        return (
          this.mode === 'dayCompleted' ||
          this.mode === 'completeDay' ||
          (this.mode === 'planner' && !this.isTaskPlanned)
        )
      },
    },

    methods: {
      isDayCompleted () {
        const now = moment().startOf('day')
        const lastCompleteRaw = window.localStorage.getItem('last_day_completed')
        if (lastCompleteRaw == null) {
          return false
        }
        const lastComplete = moment(lastCompleteRaw, 'YYYY-MM-DD').startOf('day')
        return now.isSameOrBefore(lastComplete)
      },

      completeDay () {
        this.mode = 'dayCompleted'
        const today = moment().startOf('day').format('YYYY-MM-DD')
        window.localStorage.setItem('last_day_completed', today)
      },

      millisecondsBeforeEndOfDay () {
        const now = new Date()
        return new Date(now.getFullYear(), now.getMonth(), now.getDate(), 18, 0, 0, 0) - now
      },

      isEndOfDay () {
        return this.millisecondsBeforeEndOfDay() <= 0
      },
    },

    created () {
      if (!this.isEndOfDay()) {
        const setTimeoutIn = this.millisecondsBeforeEndOfDay()
        this.setEndOfDayTimeout = setTimeout(() => { this.endOfDay = true }, setTimeoutIn)
      }
    },

    destroyed () {
      if (this.setEndOfDayTimeout) {
        window.clearTimeout(this.setEndOfDayTimeout)
      }
    }
  }
</script>

<style lang="scss">
  .app-page-today .day-completed {
    text-align: center;

    > .text-secondary {
      margin-top: 1.5rem;
    }
  }

  .app-page-today .complete-day {
    padding-top: 2rem;
    padding-bottom: 2rem;

    text-align: center;
  }

  .app-page-today .tasks-complete-day {
    max-width: 30rem;
  }
</style>
