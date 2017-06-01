<template>
  <div v-if="ready" class="tasks-backlog-page">
    <task-list :tasks="tasks" notoggle></task-list>
    <create-task-form></create-task-form>
  </div>
  <error-page v-else-if="error" :message="error"></error-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import CreateTaskForm from '../../forms/CreateTask'
  import TaskList from '../../tasks/TaskList'
  import ErrorPage from '../Error'
  import LoadingPage from '../Loading'

  export default {

    name: 'tasks-backlog-page',

    components: {
      CreateTaskForm,
      TaskList,
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
