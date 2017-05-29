<template>
  <app-content sidebar contentClass="dashboard-page">
    <p v-if="!user.activated" v-html="$t('pages.dashboard.activationInstructions', { email: user.email })"></p>

    <container v-if="inProgressProjects" row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        <span v-html="$t('pages.dashboard.dueOn', { date: project.dueAtLabel })" ></span>
      </card>
    </container>

    <task-item v-for="task in tasks" :key="task.id" :task="task"></task-item>
    <template v-if="tasks.length > 0">
      <btn
        v-if="!createTaskEnabled"
        type="primary"
        @click="createTaskEnabled = true"
      >
        <icon name="plus"></icon>
        {{ $t('pages.dashboard.createTask') }}
      </btn>
      <create-task-form
        v-else
        :dueAt="dueAt"
        :onCancel="disableCreateTask"
        autoFocus
      ></create-task-form>
    </template>
    <router-link v-else to="/tasks/planning">{{ $t('pages.dashboard.planning') }}</router-link>
  </app-content>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'
  import CreateTaskForm from '../forms/CreateTask'
  import TaskItem from '../tasks/TaskItem'

  export default {

    name: 'dashboard-page',

    components: {
      CreateTaskForm,
      TaskItem,
    },

    data () {
      return {
        createTaskEnabled: false,
        dueAt: moment().endOf('day'),
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        inProgressProjects: 'projects/listInProgress',
        tasks: 'tasks/listForToday',
      }),
    },

    methods: {
      disableCreateTask () {
        this.createTaskEnabled = false
      },
    },

  }
</script>

<style>

  .dashboard-page .container.row > .card {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 0;
  }

  .dashboard-page .list-item:last-of-type {
    margin-bottom: 10px;
  }

</style>
