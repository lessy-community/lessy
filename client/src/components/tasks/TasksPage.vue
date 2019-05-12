<template>
  <app-page v-if="resourcesReady" name="tasks" layout="application">
    <app-header :title="$t('tasks.page.title')" nobrand fluid slot="header">
      <user-popover slot="right">
      </user-popover>
    </app-header>

    <ly-section :title="$tc('tasks.page.tasksNumber', tasks.length, { count: tasks.length })">
      <task-create-form main :show-warning="tasks.length > 30"></task-create-form>
      <task-list :tasks="tasks"></task-list>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from '@/components/mixins/ResourcesLoader'

  import UserPopover from '@/components/users/UserPopover'

  import TaskCreateForm from './TaskCreateForm'
  import TaskList from './TaskList'

  export default {
    mixins: [ResourcesLoader],

    components: {
      UserPopover,
      TaskCreateForm,
      TaskList,
    },

    computed: {
      ...mapGetters({
        tasks: 'tasks/listBacklog',
      }),
    },
  }
</script>
