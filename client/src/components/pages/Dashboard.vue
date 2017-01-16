<template>
  <div class="dashboard-page">
    <p v-if="!user.activated">
      We sent you an email at {{ user.email }}.<br />
      Follow its instructions to be able to access your projects later.
    </p>

    <container row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        Due on <b>{{ project.dueAtLabel }}</b>
      </card>
    </container>

    <list-item v-for="project in notStartedProjects">
      <router-link :to="project.urlShow">
        {{ project.name }}
        <template v-if="project.isStopped">
          (stopped on {{ project.stoppedAtLabel }})
        </template>
      </router-link>
    </list-item>

    <btn
      v-if="!createFormEnabled"
      type="primary"
      @click="createFormEnabled = true"
    >
      + create a project
    </btn>
    <create-project-form v-else :onCancel="disableCreateForm"></create-project-form>

    <div v-if="numberFinishedProjects > 0" class="projects-finished">
      <btn v-if="!showFinishedProjects" type="secondary" @click="loadFinishedProjects">
        <template v-if="numberFinishedProjects === 1">
          See your finished project
        </template>
        <template v-else>
          See your {{ numberFinishedProjects }} finished projects
        </template>
      </btn>
      <btn v-else type="secondary" @click="showFinishedProjects = false">
        <template v-if="numberFinishedProjects === 1">
          Hide project
        </template>
        <template v-else>
          Hide finished projects
        </template>
      </btn>

      <list-item v-if="showFinishedProjects" v-for="project in finishedProjects">
        <router-link :to="project.urlShow">
          {{ project.name }}
          (finished on {{ project.finishedAtLabel }})
        </router-link>
      </list-item>
    </div>
  </div>
</template>

<script>
  import { mapGetters, mapState } from 'vuex'
  import CreateProjectForm from '../forms/CreateProject'

  export default {

    name: 'dashboard-page',

    components: {
      CreateProjectForm,
    },

    data () {
      return {
        createFormEnabled: false,
        showFinishedProjects: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        inProgressProjects: 'projects/listInProgress',
        notStartedProjects: 'projects/listNotStarted',
        finishedProjects: 'projects/listFinished',
      }),
      ...mapState({
        numberFinishedProjects: state => state.projects.numberFinished,
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
      },

      loadFinishedProjects () {
        const { dispatch, getters } = this.$store
        dispatch('projects/getFinished', {
          userIdentifier: getters['users/current'].identifier,
        }).then(() => { this.showFinishedProjects = true })
      },
    },

  }
</script>

<style>

  .container > .dashboard-page {
    padding-top: 30px;
    padding-bottom: 60px;
  }

  .dashboard-page .list-item:last-of-type {
    margin-bottom: 10px;
  }

  .dashboard-page .card {
    width: 30%;
  }

  .dashboard-page > .container {
    justify-content: space-between;
  }

  .dashboard-page .projects-finished {
    margin-top: 30px;
  }

</style>
