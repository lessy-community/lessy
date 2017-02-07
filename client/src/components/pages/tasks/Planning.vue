<template>
  <div v-if="ready" class="tasks-planning-page">
    <div v-if="pendingTasks.length > 0" class="tasks-pending-box">
      <p>{{ $t('pages.tasks.planning.pendingInfo') }}</p>
      <div>
        <container v-for="task in pendingTasks" row class="task">
          <div class="task-label adapt">
            {{ task.label }} {{ $t('pages.tasks.planning.dueOn', { date: task.dueAtLabel }) }}
          </div>
          <div>
            <btn type="secondary" @click="finishTask(task)">{{ $t('pages.tasks.planning.didIt') }}</btn>
            <btn type="primary" @click="restartTask(task)">{{ $t('pages.tasks.planning.replan') }}</btn>
          </div>
        </container>
      </div>
    </div>

    <div class="list">
      <list-item v-for="task in tasksForToday" :class="['task', { finished: task.isFinished }]">
        {{ task.label }}
      </list-item>
    </div>
    <create-task-form></create-task-form>

    <div class="planning-finish">
      <router-link to="/dashboard" class="btn">{{ $t('pages.tasks.planning.back') }}</router-link>
    </div>
  </div>
  <error-page v-else-if="error" :message="error"></error-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import CreateTaskForm from '../../forms/CreateTask'
  import ErrorPage from '../Error'
  import LoadingPage from '../Loading'

  export default {

    name: 'tasks-planning-page',

    components: {
      CreateTaskForm,
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
        tasksForToday: 'tasks/listForToday',
        pendingTasks: 'tasks/listPending',
      }),
    },

    methods: {
      finishTask (task) {
        this.$store.dispatch('tasks/finish', { task })
      },

      restartTask (task) {
        this.$store.dispatch('tasks/restart', { task })
      },
    },

    mounted () {
      this.$store
        .dispatch('tasks/getPending')
        .then(() => {
          this.ready = true
        })
        .catch((failure) => {
          this.error = failure.data.message
        })
    },

  }
</script>

<style scoped>

  .tasks-pending-box {
    margin-bottom: 25px;
    padding: 25px;

    background-color: #ffeedd;
    border: 1px solid #aaa;
    border-radius: 5px;
  }
  .tasks-pending-box p {
    margin-top: 0;
    margin-bottom: 25px;

    color: #666;
    text-align: center;
    font-style: italic;
  }

  .list {
    margin-bottom: 10px;
  }
  .task {
    padding: 5px 5px 5px 10px;
  }
  .task.finished {
    color: #999;
    text-decoration: line-through;
  }
  .container.task {
    align-items: center;
  }
  .list-item.task {
    padding-top: 10px;
    padding-bottom: 10px;

    border: none;
  }

  .planning-finish {
    text-align: right;
  }

</style>
