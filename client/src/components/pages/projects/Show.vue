<template>
  <div class="project-show-page">
    <container row align="center">
      <h1>{{ project.name }}</h1>
      <router-link :to="project.urlEdit">Edit</router-link>
    </container>
    <p v-if="project.description">
      {{ project.description }}
    </p>
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
