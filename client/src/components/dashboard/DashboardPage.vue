<template>
  <app-page v-if="resourcesReady" name="dashboard" layout="application">
    <layout-application-header slot="header" :title="$t('dashboard.page.title')">
    </layout-application-header>

    <ly-card v-if="!user.activated">
      <p v-html="$t('dashboard.page.activationInstructions', { email: user.email })"></p>
      <ly-button
        v-if="!activationEmailResent"
        icon="envelope-o"
        @click="resendActivationEmail"
      >
        {{ $t('dashboard.page.resendActivationInstructions') }}
      </ly-button>
      <p v-else class="text-success">
        <ly-icon name="check"></ly-icon>
        {{ $t('dashboard.page.resendActivationInstructionsDone') }}
      </p>
    </ly-card>

    <ly-section :title="$t('dashboard.page.projectsInProgress')">
      <project-card-deck :projects="projects"></project-card-deck>
    </ly-section>

    <ly-section :title="$tc('dashboard.page.tasksForToday', tasks.length, { count: tasks.length })">
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
    </ly-section>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import ResourcesLoader from 'src/components/mixins/ResourcesLoader'

  import LayoutApplicationHeader from 'src/components/layouts/LayoutApplicationHeader'

  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskList from 'src/components/tasks/TaskList'
  import ProjectCardDeck from 'src/components/projects/ProjectCardDeck'

  export default {
    mixins: [ResourcesLoader],

    components: {
      LayoutApplicationHeader,
      TaskCreateForm,
      TaskList,
      ProjectCardDeck,
    },

    data () {
      return {
        createTaskEnabled: false,
        plannedAt: moment().endOf('day'),
        activationEmailResent: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        projects: 'projects/listInProgress',
        tasks: 'tasks/listForToday',
      }),
    },

    methods: {
      resendActivationEmail () {
        this.$store
          .dispatch('users/resendActivationEmail', { email: this.user.email })
          .then(() => { this.activationEmailResent = true })
      },
    },
  }
</script>
