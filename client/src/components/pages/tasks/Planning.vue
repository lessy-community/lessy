<template>
  <div v-if="ready" class="tasks-planning-page">
    <div v-if="pendingTasks.length > 0" class="box tasks-pending">
      <p>{{ $t('pages.tasks.planning.pendingInfo') }}</p>
      <div class="list">
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

    <div v-if="backloggedTasks.length > 0" class="box tasks-backlogged">
      <p>{{ $t('pages.tasks.planning.backlogInfo') }}</p>
      <div class="list">
        <container v-for="task in backloggedTasks" row class="task">
          <div class="task-label adapt">
            {{ task.label }}
          </div>
          <div>
            <btn type="primary" @click="restartTask(task)">{{ $t('pages.tasks.planning.plan') }}</btn>
          </div>
        </container>
      </div>
    </div>

    <div class="list">
      <task-item
        v-for="task in tasksForToday"
        :key="task.id"
        :task="task"
        disable-toggle
      ></task-item>
    </div>
    <create-task-form :dueAt="dueAt"></create-task-form>

    <div class="planning-finish">
      <router-link to="/dashboard" class="btn">{{ $t('pages.tasks.planning.back') }}</router-link>
    </div>
  </div>
  <error-page v-else-if="error" :message="error"></error-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import CreateTaskForm from '../../forms/CreateTask'
  import TaskItem from '../../tasks/TaskItem'
  import ErrorPage from '../Error'
  import LoadingPage from '../Loading'

  export default {

    name: 'tasks-planning-page',

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
        dueAt: moment().endOf('day'),
      }
    },

    computed: {
      ...mapGetters({
        tasksForToday: 'tasks/listForToday',
        pendingTasks: 'tasks/listPending',
        backloggedTasks: 'tasks/listBacklog',
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
      Promise.all([
        this.$store.dispatch('tasks/getPending'),
        this.$store.dispatch('tasks/getBacklog'),
      ])
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

  .box {
    margin-bottom: 25px;
    padding: 25px;

    border: 1px solid #aaa;
    border-radius: 5px;
  }
  .box p {
    margin-top: 0;
    margin-bottom: 25px;

    color: #666;
    text-align: center;
    font-style: italic;
  }

  .box.tasks-pending {
    background-color: #ffeedd;
  }
  .box.tasks-backlogged {
    background-color: #eeeeff;
  }

  .container.task {
    margin-bottom: 5px;

    align-items: center;
  }

  .planning-finish {
    text-align: right;
  }

</style>
