<template>
  <div class="project-show-page">
    <router-link :to="project.urlEdit">Edit</router-link>
    <p v-if="project.description" class="project-description">{{ project.description }}</p>
    <p v-else>
      <em>Aucune description</em>
    </p>
  </div>
</template>

<script>
  export default {

    name: 'project-show-page',

    props: {
      'project': { type: Object, required: true },
    },

  }
</script>

<style scoped>

  .project-description {
    font-size: 1.1rem;
    white-space: pre-wrap;
  }

</style>
