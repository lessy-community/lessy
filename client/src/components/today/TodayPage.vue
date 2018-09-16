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

    <tasks-planner :tasks="tasks"></tasks-planner>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
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

    computed: {
      ...mapGetters({
        user: 'users/current',
        tasks: 'tasks/listForToday',
        todayFeatureEnabled: 'features/todayEnabled',
      }),

      centered () {
        return this.tasks.length === 0
      },
    },

    watch: {
      resourcesReady: function (ready) {
        if (ready && !this.todayFeatureEnabled) {
          this.$router.push('/dashboard')
        }
      },
    },

    mounted () {
      if (this.resourcesReady && !this.todayFeatureEnabled) {
        this.$router.push('/dashboard')
      }
    },
  }
</script>
