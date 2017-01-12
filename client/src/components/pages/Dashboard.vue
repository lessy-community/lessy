<template>
  <div v-if="error" class="error-page">
    {{ error }}
  </div>
  <div v-else-if="!user" class="loading-page">
    Chargement en cours…
  </div>
  <div v-else class="dashboard-page">
    <p v-if="!user.username">
      We sent you an email at {{ user.email }}.<br />
      Follow its instructions to be able to access your projects later.
    </p>

    <create-project-form />

    <div v-for="project in projects">
      {{ project.name }}
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex'
import CreateProjectForm from '../forms/CreateProject'

export default {
  name: 'dashboard-page',
  components: {
    CreateProjectForm,
  },
  data () {
    return {
      error: null,
    }
  },
  computed: {
    ...mapState({
      user: (state) => state.users.current,
    }),
    ...mapGetters({
      projects: 'projects/list',
    }),
  },
  mounted () {
    this.$store
      .dispatch('users/getCurrent')
      .catch((error) => {
        this.error = error.data.message
      })
  },
}
</script>
