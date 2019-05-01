<template>
  <ly-modal
    :title="$t('projects.modals.startNewTitle')"
    @close="$emit('close')"
  >
    <projects-start-new-form
      autofocus
      @success="redirectToProject"
      @cancel="$emit('close')"
    ></projects-start-new-form>
  </ly-modal>
</template>

<script>
  import ProjectsStartNewForm from './ProjectsStartNewForm'

  export default {
    components: {
      ProjectsStartNewForm,
    },

    methods: {
      redirectToProject (project) {
        this.$router.push(project.urlShow)
      },
    },
  }
</script>
