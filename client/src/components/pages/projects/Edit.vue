<template>
  <div class="project-edit-page">
    <container row align="center">
      <h1>Editing {{ project.name }}</h1>
      <router-link :to="project.urlShow">Cancel</router-link>
    </container>

    <edit-project-form
      :project="project"
      :onSuccess="redirectToShow"
      :onCancel="redirectToShow"
    ></edit-project-form>
  </div>
</template>

<script>
  import EditProjectForm from '../../forms/EditProject'

  export default {

    name: 'project-edit-page',

    props: {
      'project': { type: Object, required: true },
    },

    components: {
      EditProjectForm,
    },

    methods: {
      redirectToShow () {
        this.$router.push(this.project.urlShow)
      },
    },

  }
</script>
