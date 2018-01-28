<template>
  <ly-modal :title="$t('projects.modals.startTitle')">
    <p class="text-secondary">
      {{ project.name }}
    </p>

    <project-start-form
      :project="project"
      @success="$emit('close')"
      @cancel="$emit('close')"
    ></project-start-form>
  </ly-modal>
</template>

<script>
  import ProjectStartForm from './ProjectStartForm'

  export default {
    props: {
      project: { type: Object, required: true },
    },

    components: {
      ProjectStartForm,
    },
  }
</script>
