<template>
  <div class="tasks-planning-page">
    <div v-if="backloggedTasks.length > 0" class="box tasks-backlogged">
      <p>{{ $t('pages.tasks.planning.backlogInfo') }}</p>
      <div class="list">
        <container v-for="task in backloggedTasks" row class="task">
          <div class="task-label adapt">
            {{ task.label }}
          </div>
          <div>
            <btn type="primary" @click="startTask(task)">{{ $t('pages.tasks.planning.plan') }}</btn>
          </div>
        </container>
      </div>
    </div>

    <task-list :tasks="tasksForToday" notoggle></task-list>
    <create-task-form :dueAt="dueAt"></create-task-form>

    <div class="planning-finish">
      <router-link to="/dashboard" class="btn">{{ $t('pages.tasks.planning.back') }}</router-link>
    </div>
  </div>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import CreateTaskForm from '../../forms/CreateTask'
  import TaskList from '../../tasks/TaskList'

  export default {
    components: {
      CreateTaskForm,
      TaskList,
    },

    data () {
      return {
        dueAt: moment().endOf('day'),
      }
    },

    computed: {
      ...mapGetters({
        tasksForToday: 'tasks/listForToday',
        backloggedTasks: 'tasks/listBacklog',
      }),
    },

    methods: {
      startTask (task) {
        this.$store.dispatch('tasks/start', { task })
      },
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
