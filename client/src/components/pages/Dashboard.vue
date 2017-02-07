<template>
  <app-content sidebar contentClass="dashboard-page">
    <p v-if="!user.activated" v-html="$t('pages.dashboard.activationInstructions', { email: user.email })"></p>

    <container v-if="inProgressProjects" row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        <span v-html="$t('pages.dashboard.dueOn', { date: project.dueAtLabel })" ></span>
      </card>
    </container>

    <list-item v-for="task in tasks" @click="toggleFinishTask(task)" :class="['task', { finished: task.isFinished }]">
      <template v-if="task.isFinished">
        <icon name="check-square-o"></icon>
      </template>
      <template v-else>
        <icon name="square-o"></icon>
      </template>
      {{ task.label }}
    </list-item>
    <template v-if="tasks.length > 0">
      <btn
        v-if="!createTaskEnabled"
        type="primary"
        @click="createTaskEnabled = true"
      >
        <icon name="plus"></icon>
        {{ $t('pages.dashboard.createTask') }}
      </btn>
      <create-task-form v-else :onCancel="disableCreateTask" autoFocus></create-task-form>
    </template>
    <router-link v-else to="/tasks/planning">{{ $t('pages.dashboard.planning') }}</router-link>
  </app-content>
</template>

<script>
  import { mapGetters } from 'vuex'
  import CreateTaskForm from '../forms/CreateTask'

  export default {

    name: 'dashboard-page',

    components: {
      CreateTaskForm,
    },

    data () {
      return {
        createTaskEnabled: false,
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

      toggleFinishTask (task) {
        if (task.isFinished) {
          this.$store.dispatch('tasks/restart', { task })
        } else {
          this.$store.dispatch('tasks/finish', { task })
        }
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

  .dashboard-page .task.finished {
    color: #999;
    text-decoration: line-through;
  }

</style>
