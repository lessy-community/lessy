<template>
  <div class="tasks-backlog-page">
    <task-list :tasks="tasks" notoggle></task-list>
    <create-task-form></create-task-form>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  import CreateTaskForm from '../../forms/CreateTask'
  import TaskList from '../../tasks/TaskList'

  export default {
    components: {
      CreateTaskForm,
      TaskList,
    },

    computed: {
      ...mapGetters({
        tasks: 'tasks/listBacklog',
      }),
    },
  }
</script>
