<template>
  <app-page v-if="resourcesReady" name="today" layout="application">
    <app-header :title="$t('today.page.title')" fluid slot="header">
      <user-popover slot="right">
      </user-popover>
    </app-header>

    <ly-section :title="$tc('today.page.tasksForToday', tasks.length, { count: tasks.length })">
      <task-list :tasks="tasks"></task-list>

      <template v-if="!createTaskEnabled">
        <ly-button
          icon="plus"
          type="primary"
          @click="createTaskEnabled = true"
        >
          {{ $t('today.page.createTask') }}
        </ly-button>

        {{ $t('today.page.or') }}

        <router-link to="/tasks/backlog">{{ $t('today.page.backlog') }}</router-link>
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

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TaskCreateForm,
      TaskList,
    },

    data () {
      return {
        createTaskEnabled: false,
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
