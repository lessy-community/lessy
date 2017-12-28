<template>
  <ly-modal :title="$t('tasks.modals.attachProjectTitle')">
    <p class="text-secondary">«&nbsp;{{ task.label }}&nbsp;»</p>

    <task-attach-project-form
      :task="task"
      @success="$emit('close')"
      @cancel="$emit('close')"
      autofocus
    ></task-attach-project-form>
  </ly-modal>
</template>

<script>
  import TaskAttachProjectForm from './TaskAttachProjectForm'

  export default {
    props: {
      task: { type: Object, required: true },
    },

    components: {
      TaskAttachProjectForm,
    },
  }
</script>
