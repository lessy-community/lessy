<template>
  <ly-modal
    :title="$t('projects.modals.deleteTitle')"
    @close="$emit('close')"
  >
    <p>
      {{ $t('projects.modals.deleteIntro', { projectName: project.name }) }}
    </p>

    <ly-button type="primary" @click="deleteProject">
      {{ $t('projects.modals.deleteConfirm') }}
    </ly-button>
    <ly-button @click="$emit('close')">
      {{ $t('projects.modals.deleteCancel') }}
    </ly-button>
  </ly-modal>
</template>

<script>
  export default {
    props: {
      project: { type: Object, required: true },
    },

    methods: {
      deleteProject () {
        this.$store
          .dispatch('projects/delete', { project: this.project })
          .then(() => this.$router.push('/projects'))
      },
    },
  }
</script>
