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

    <list-item v-for="project in notInProgressProjects">
      <router-link :to="project.urlShow">
        {{ project.name }}
        <span v-if="project.isFinished">(finished)</span>
      </router-link>
    </list-item>

    <btn
      v-if="!createFormEnabled"
      type="secondary"
      @click="createFormEnabled = true"
    >
      + create a project
    </btn>
    <create-project-form v-else :onCancel="disableCreateForm"></create-project-form>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import CreateProjectForm from '../forms/CreateProject'

  export default {

    name: 'dashboard-page',

    components: {
      CreateProjectForm,
    },

    data () {
      return {
        createFormEnabled: false,
      }
    },

    computed: {
      ...mapGetters({
        user: 'users/current',
        inProgressProjects: 'projects/listInProgress',
        notInProgressProjects: 'projects/listNotInProgress',
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
      }
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

</style>
