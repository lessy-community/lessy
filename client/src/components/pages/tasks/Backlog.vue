<template>
  <div v-if="ready" class="tasks-backlog-page">
    <div class="list">
      <task-item
        v-for="task in tasks"
        :key="task.id"
        :task="task"
        disable-toggle
      ></task-item>
    </div>
    <create-task-form></create-task-form>
  </div>
  <error-page v-else-if="error" :message="error"></error-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import CreateTaskForm from '../../forms/CreateTask'
  import TaskItem from '../../tasks/TaskItem'
  import ErrorPage from '../Error'
  import LoadingPage from '../Loading'

  export default {

    name: 'tasks-backlog-page',

    components: {
      CreateTaskForm,
      TaskItem,
      ErrorPage,
      LoadingPage,
    },

    data () {
      return {
        error: null,
        ready: false,
      }
    },

    computed: {
      ...mapGetters({
        tasks: 'tasks/listBacklog',
      }),
    },

    methods: {
    },

    mounted () {
      this.$store
        .dispatch('tasks/getBacklog')
        .then(() => {
          this.ready = true
        })
        .catch((failure) => {
          this.error = failure.data.message
        })
    },

  }
</script>
