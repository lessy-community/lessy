<template>
  <app-page name="project-start">
    <ly-section :title="project.name">
      <project-start-form
        :project="project"
        :onSuccess="redirectToShow"
        :onCancel="redirectToShow"
      ></project-start-form>
    </ly-section>
  </app-page>
</template>

<script>
  import ProjectStartForm from './ProjectStartForm'

  export default {
    props: {
      'project': { type: Object, required: true },
    },

    components: {
      ProjectStartForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },
  }
</script>
