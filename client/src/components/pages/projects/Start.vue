<template>
  <div class="project-start-page">
    <start-project-form
      :project="project"
      :onSuccess="redirectToShow"
      :onCancel="redirectToShow"
    ></start-project-form>
  </div>
</template>

<script>
  import StartProjectForm from '../../forms/StartProject'

  export default {

    name: 'project-start-page',

    props: {
      'project': { type: Object, required: true },
    },

    components: {
      StartProjectForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },

  }
</script>
