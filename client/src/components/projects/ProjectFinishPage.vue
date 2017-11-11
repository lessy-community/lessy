<template>
  <app-page name="project-finish">
    <ly-section :title="project.name">
      <p v-html="$t('projects.finishPage.intro', { projectName: project.name })"></p>

      <project-finish-form
        :project="project"
        :onSuccess="redirectToShow"
        :onCancel="redirectToShow"
      ></project-finish-form>
    </ly-section>
  </app-page>
</template>

<script>
  import ProjectFinishForm from './ProjectFinishForm'

  export default {
    props: {
      'project': { type: Object, required: true },
    },

    components: {
      ProjectFinishForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },
  }
</script>
