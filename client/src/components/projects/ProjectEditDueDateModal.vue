<template>
  <ly-modal
    :title="$t('projects.modals.editDueDateTitle')"
    @close="$emit('close')"
  >
    <p class="text-secondary">
      {{ project.name }}
    </p>

    <project-edit-due-date-form
      :project="project"
      @success="$emit('close')"
      @cancel="$emit('close')"
    ></project-edit-due-date-form>
  </ly-modal>
</template>

<script>
  import ProjectEditDueDateForm from './ProjectEditDueDateForm'

  export default {
    props: {
      project: { type: Object, required: true },
    },

    components: {
      ProjectEditDueDateForm,
    },
  }
</script>
