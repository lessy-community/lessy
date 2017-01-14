<template>
  <div class="dashboard-page">
    <p v-if="!user.activated">
      We sent you an email at {{ user.email }}.<br />
      Follow its instructions to be able to access your projects later.
    </p>

    <create-project-form />

    <div v-for="project in projects">
      <router-link :to="project.url">{{ project.name }}</router-link>
    </div>
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

    computed: {
      ...mapGetters({
        user: 'users/current',
        projects: 'projects/list',
      }),
    },

  }
</script>
