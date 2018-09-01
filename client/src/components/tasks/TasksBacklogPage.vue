<template>
  <app-page v-if="resourcesReady" name="tasks-backlog" layout="application">
    <tasks-header slot="header"></tasks-header>

    <ly-section :title="$tc('tasks.backlogPage.tasksNumber', tasks.length, { count: tasks.length })">
      <task-create-form :show-warning="tasks.length > 30"></task-create-form>
      <task-list :tasks="tasks"></task-list>
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import TasksHeader from './TasksHeader'
  import TaskCreateForm from './TaskCreateForm'
  import TaskList from './TaskList'

  export default {
    mixins: [ResourcesLoader],

    components: {
      TasksHeader,
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
