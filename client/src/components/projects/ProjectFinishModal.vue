<template>
  <ly-modal :title="$t('projects.modals.finishTitle')">
    <p class="text-secondary">
      {{ $t('projects.modals.finishIntro', { projectName: project.name }) }}
    </p>

    <project-finish-form
      :project="project"
      @success="$emit('close')"
      @cancel="$emit('close')"
    ></project-finish-form>
  </ly-modal>
</template>

<script>
  import ProjectFinishForm from './ProjectFinishForm'

  export default {
    props: {
      project: { type: Object, required: true },
    },

    components: {
      ProjectFinishForm,
    },
  }
</script>
