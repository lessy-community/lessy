<template>
  <app-page name="tasks-backlog">
    <task-list :tasks="tasks" notoggle></task-list>
    <task-create-form></task-create-form>
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
