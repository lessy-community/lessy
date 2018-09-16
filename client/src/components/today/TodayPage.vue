<template>
  <app-page v-if="resourcesReady" name="today" layout="application">
    <app-header :title="$t('today.page.title')" fluid slot="header">
      <user-popover slot="right">
      </user-popover>
    </app-header>

    <ly-section :title="$tc('today.page.tasksForToday', tasks.length, { count: tasks.length })">
      <task-list :tasks="tasks"></task-list>

      <ly-button
        icon="calendar-plus-o"
        type="primary"
        @click="showTaskPlanModal = true"
      >
        {{ $t('today.page.planTask') }}
      </ly-button>
    </ly-section>

    <task-plan-modal v-if="showTaskPlanModal" @close="showTaskPlanModal = false">
    </task-plan-modal>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import UserPopover from 'src/components/users/UserPopover'

  import TaskList from 'src/components/tasks/TaskList'
  import TaskPlanModal from 'src/components/tasks/TaskPlanModal'

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TaskList,
      TaskPlanModal,
    },

    data () {
      return {
        showTaskPlanModal: false,
        plannedAt: moment().endOf('day'),
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        tasks: 'tasks/listForToday',
        todayFeatureEnabled: 'features/todayEnabled',
      }),
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
