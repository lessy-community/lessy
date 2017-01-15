<template>
  <div class="project-show-page">
    <router-link :to="project.urlEdit">Edit</router-link>
    <template v-if="!project.isStarted">
      <router-link
        v-if="canStartProject"
        :to="project.urlStart"
      >
        Start this project
      </router-link>
      <span
        v-else
        class="disabled"
        title="You already reached the maximum of started projects"
      >
        Start this project
      </span>
    </template>
    <div v-else>
      <form-group label="Started on">
        <static-field :value="project.startedAtLabel" />
      </form-group>
      <form-group label="Due on">
        <static-field :value="project.dueAtLabel" />
      </form-group>
    </div>

    <p v-if="project.description" class="project-description">{{ project.description }}</p>
    <p v-else>
      <em>Aucune description</em>
    </p>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {

    name: 'project-show-page',

    props: {
      'project': { type: Object, required: true },
    },

    computed: {
      ...mapGetters({
        canStartProject: 'projects/canStartProject',
      }),
    },

  }
</script>

<style scoped>

  .project-description {
    font-size: 1.1rem;
    white-space: pre-wrap;
  }

  .disabled {
    color: #666;
    cursor: not-allowed;
  }

</style>
