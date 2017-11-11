<template>
  <app-page name="tasks-backlog">
    <ly-section :title="$tc('tasks.backlogPage.tasksNumber', tasks.length, { count: tasks.length })">
      <task-create-form :show-warning="tasks.length > 30"></task-create-form>
      <task-list :tasks="tasks"></task-list>
    </ly-section>
  </app-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import TaskCreateForm from './TaskCreateForm'
  import TaskList from './TaskList'

  export default {
    components: {
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
