<template>
  <app-page name="tasks-backlog">
    <ly-section :title="$tc('tasks.backlogPage.tasksNumber', tasks.length, { count: tasks.length })">
      <task-list :tasks="tasks"></task-list>
      <task-create-form></task-create-form>
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
