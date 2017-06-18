<template>
  <app-content sidebar contentClass="dashboard-page">
    <p v-if="!user.activated" v-html="$t('pages.dashboard.activationInstructions', { email: user.email })"></p>

    <container v-if="inProgressProjects" row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        <span v-html="$t('pages.dashboard.dueOn', { date: project.dueAtLabel })" ></span>
      </card>
    </container>

    <task-list :tasks="tasks"></task-list>
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
  import TaskList from '../tasks/TaskList'

  export default {

    name: 'dashboard-page',

    components: {
      CreateTaskForm,
      TaskList,
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

</style>
