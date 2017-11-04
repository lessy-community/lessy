<template>
  <app-page name="project-finish">
    <p v-html="$t('projects.finishPage.intro', { projectName: project.name })"></p>

    <project-finish-form
      :project="project"
      :onSuccess="redirectToShow"
      :onCancel="redirectToShow"
    ></project-finish-form>
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
