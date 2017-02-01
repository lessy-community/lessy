<template>
  <div class="dashboard-page">
    <p v-if="!user.activated" v-html="$t('pages.dashboard.activationInstructions', { email: user.email })"></p>

    <container v-if="inProgressProjects" row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        <span v-html="$t('pages.dashboard.dueOn', { date: project.dueAtLabel })" ></span>
      </card>
    </container>

    <list-item v-for="task in tasks" :class="['task', { finished: task.isFinished }]">
      <a
        v-if="!task.isFinished"
        href="#"
        @click.prevent="finishTask(task)"
      >
        ⬜ {{ task.label }}
      </a>
      <span v-else>
        ⬛ {{ task.label }}
      </span>
    </list-item>
    <btn
      v-if="!createTaskEnabled"
      type="primary"
      @click="createTaskEnabled = true"
    >
      {{ $t('pages.dashboard.createTask') }}
    </btn>
    <create-task-form v-else :onCancel="disableCreateTask"></create-project-form>
  </div>
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
        tasks: 'tasks/list',
      }),
    },

    methods: {
      disableCreateTask () {
        this.createTaskEnabled = false
      },

      finishTask (task) {
        this.$store.dispatch('tasks/finish', { task })
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
