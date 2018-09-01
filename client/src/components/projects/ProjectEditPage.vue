<template>
  <app-page name="project-edit" layout="application">
    <projects-header slot="header"></projects-header>
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
  import ProjectsHeader from './ProjectsHeader'
  import ProjectEditForm from './ProjectEditForm'

  export default {
    props: {
      'project': { type: Object, required: true },
    },

    components: {
      ProjectsHeader,
      ProjectEditForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },

  }
</script>
