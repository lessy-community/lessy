<template>
  <app-page name="project-edit">
    <ly-section :title="project.name">
      <project-edit-form
        :project="project"
        @success="redirectToShow"
        @cancel="redirectToShow"
      ></project-edit-form>
    </ly-section>
  </app-page>
</template>

<script>
  import ProjectEditForm from './ProjectEditForm'

  export default {
    props: {
      'project': { type: Object, required: true },
    },

    components: {
      ProjectEditForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },

  }
</script>
