<template>
  <div class="project-show-page">
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
    <container v-else row align="center">
      <div>
        <form-group label="Started on">
          <static-field :value="project.startedAtLabel" />
        </form-group>
        <form-group v-if="project.isFinished" label="Finished on">
          <static-field :value="project.finishedAtLabel" />
        </form-group>
        <form-group v-else label="Due on">
          <static-field :value="project.dueAtLabel" />
        </form-group>
      </div>
      <div v-if="!project.isFinished" class="project-finish-btn adapt">
        <router-link :to="project.urlFinish" class="btn primary">Finish it, now!</router-link>
      </div>
    </container>

    <p v-if="project.description" class="project-description">{{ project.description }}</p>
    <p v-else>
      <em>
        There is no description for this project yet.
        <router-link :to="project.urlEdit">Edit?</router-link>
      </em>
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

  .project-finish-btn {
    text-align: center;
  }

  .project-description {
    font-size: 1.1rem;
    white-space: pre-wrap;
  }

  .disabled {
    color: #666;
    cursor: not-allowed;
  }

</style>
