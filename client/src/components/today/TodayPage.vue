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

    <div v-if="dayCompleted" class="day-completed">
      <ly-icon name="star" size="large"></ly-icon>

      <p class="text-secondary">
        {{ $t('today.page.dayCompleted') }}
      </p>
    </div>
    <tasks-planner
      v-else
      :todoTasks="todoTasks"
      :finishedTasks="finishedTasks"
      :showEndOfDayButton="endOfDay"
      @completed="completeDay"
    ></tasks-planner>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import UserPopover from 'src/components/users/UserPopover'
  import TasksPlanner from 'src/components/tasks/TasksPlanner'

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TasksPlanner,
    },

    data () {
      return {
        dayCompleted: this.isDayCompleted(),
        endOfDay: this.isEndOfDay(),
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        todoTasks: 'tasks/listTodoForToday',
        finishedTasks: 'tasks/listFinishedToday',
      }),

      centered () {
        const tasksTotalCount = this.todoTasks.length + this.finishedTasks.length
        return this.dayCompleted || tasksTotalCount === 0
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
        this.dayCompleted = true
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
</style>
