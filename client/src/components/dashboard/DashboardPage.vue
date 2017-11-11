<template>
  <app-page name="dashboard">
    <p v-if="!user.activated" v-html="$t('dashboard.page.activationInstructions', { email: user.email })"></p>

    <project-card-deck :projects="projects"></project-card-deck>
    <task-list :tasks="tasks"></task-list>

    <template v-if="!createTaskEnabled">
      <ly-button
        icon="plus"
        type="primary"
        @click="createTaskEnabled = true"
      >
        {{ $t('dashboard.page.createTask') }}
      </ly-button>

      {{ $t('dashboard.page.or') }}

      <router-link to="/tasks/backlog">{{ $t('dashboard.page.backlog') }}</router-link>
    </template>
    <task-create-form
      v-else
      :plannedAt="plannedAt"
      :onCancel="() => { this.createTaskEnabled = false }"
      autoFocus
    ></task-create-form>
  </app-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'
  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskList from 'src/components/tasks/TaskList'
  import ProjectCardDeck from 'src/components/projects/ProjectCardDeck'

  export default {
    components: {
      TaskCreateForm,
      TaskList,
      ProjectCardDeck,
    },

    data () {
      return {
        createTaskEnabled: false,
        plannedAt: moment().endOf('day'),
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        projects: 'projects/listInProgress',
        tasks: 'tasks/listForToday',
      }),
    },
  }
</script>
