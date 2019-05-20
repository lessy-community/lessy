<template>
  <ly-modal
    :title="$t('tasks.modals.transformInProjectTitle')"
    @close="$emit('close')"
  >
    <project-create-form
      :initialName="task.label"
      main
      autofocus
      @success="onTaskTransformSuccess"
      @cancel="$emit('close')"
    ></project-create-form>
  </ly-modal>
</template>

<script>
  import ProjectCreateForm from '@/components/projects/ProjectCreateForm'

  export default {
    props: {
      task: { type: Object, required: true },
    },

    components: {
      ProjectCreateForm,
    },

    methods: {
      onTaskTransformSuccess (projectId) {
        const { task } = this
        const project = this.$store.getters['projects/findById'](projectId)

        this.$store.dispatch('tasks/abandon', { task })
        if (project) {
          this.$router.push(project.urlShow)
        }
        this.$emit('close')
      },
    },
  }
</script>
