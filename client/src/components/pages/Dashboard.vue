<template>
  <div class="dashboard-page">
    <p v-if="!user.activated">
      We sent you an email at {{ user.email }}.<br />
      Follow its instructions to be able to access your projects later.
    </p>

    <list-item v-for="project in projects">
      <router-link :to="project.urlShow">{{ project.name }}</router-link>
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
        projects: 'projects/list',
      }),
    },

    methods: {
      disableCreateForm () {
        this.createFormEnabled = false
      }
    },

  }
</script>
