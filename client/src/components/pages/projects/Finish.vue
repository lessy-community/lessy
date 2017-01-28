<template>
  <div class="project-finish-page">
    <p v-html="$t('pages.projects.finish.intro', { projectName: project.name })"></p>

    <finish-project-form
      :project="project"
      :onSuccess="redirectToShow"
      :onCancel="redirectToShow"
    ></finish-project-form>
  </div>
</template>

<script>
  import FinishProjectForm from '../../forms/FinishProject'

  export default {

    name: 'project-finish-page',

    props: {
      'project': { type: Object, required: true },
    },

    components: {
      FinishProjectForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },

  }
</script>

<style>

  .project-finish-page {
    text-align: center;
  }

  .project-finish-page p {
    font-size: 1.2rem;
    line-height: 2.5rem;
  }

  .project-finish-page .form-group {
    width: 500px;
    margin-left: auto;
    margin-right: auto;
  }
  .project-finish-page .form-group-tip {
    text-align: left;
  }
  .project-finish-page .form-group-actions .form-group-control {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .project-finish-page .form-group-actions .form-group-control .btn {
    margin-bottom: 10px;
  }

</style>
