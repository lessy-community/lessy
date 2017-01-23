<template>
  <div class="project-show-page">
    <container row align="center">
      <div v-if="project.isStarted">
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
      <div v-else-if="project.isStopped">
        <form-group label="Stopped on">
          <static-field :value="project.stoppedAtLabel" />
        </form-group>
      </div>

      <div v-if="!project.isStarted" class="project-actions adapt">
        <router-link
          v-if="canStartProject"
          :to="project.urlStart"
          class="btn primary"
        >
          Start this project
        </router-link>
        <btn
          v-else
          type="link"
          title="You already reached the maximum of started projects"
          disabled
        >
          Start this project
        </span>
      </div>
      <div v-else-if="!project.isFinished" class="project-actions adapt">
        <router-link :to="project.urlFinish" class="btn primary">Finish it</router-link>
        <btn type="danger" @click="confirmStop">Stop it, now</btn>
      </div>
    </container>

    <p v-if="project.description" class="project-description" v-html="project.mdDescription"></p>
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

    methods: {
      confirmStop () {
        if (window.confirm('Oh? The project will be marked as stopped. Can you confirm?')) {
          this.$store.dispatch('projects/stop', { project: this.project })
        }
      },
    },

  }
</script>

<style scoped>

  .project-actions {
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
