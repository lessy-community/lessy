<template>
  <div class="project-show-page">
    <container row align="center">
      <div v-if="project.isStarted">
        <form-group :label="$t('pages.projects.show.startedLabel')">
          <static-field :value="project.startedAtLabel" />
        </form-group>
        <form-group v-if="project.isFinished" :label="$t('pages.projects.show.finishedLabel')">
          <static-field :value="project.finishedAtLabel" />
        </form-group>
        <form-group v-else :label="$t('pages.projects.show.dueLabel')">
          <static-field :value="project.dueAtLabel" />
        </form-group>
      </div>
      <div v-else-if="project.isStopped">
        <form-group :label="$t('pages.projects.show.stoppedLabel')">
          <static-field :value="project.stoppedAtLabel" />
        </form-group>
      </div>

      <div v-if="!project.isStarted" class="project-actions adapt">
        <router-link
          v-if="canStartProject"
          :to="project.urlStart"
          class="btn primary"
        >
          {{ $t('pages.projects.show.startProject') }}
        </router-link>
        <btn
          v-else
          type="link"
          :title="$t('pages.projects.show.reachedMaxInProgress')"
          disabled
        >
          {{ $t('pages.projects.show.startProject') }}
        </btn>
      </div>
      <div v-else-if="!project.isFinished" class="project-actions adapt">
        <router-link :to="project.urlFinish" class="btn primary">
          {{ $t('pages.projects.show.finishProject') }}
        </router-link>
        <btn type="danger" @click="confirmStop">
          {{ $t('pages.projects.show.stopProject') }}
        </btn>
      </div>
    </container>

    <p v-if="project.description" class="project-description" v-html="project.mdDescription"></p>
    <p v-else>
      <em>
        {{ $t('pages.projects.show.noDescription') }}
        <router-link :to="project.urlEdit">
          {{ $t('pages.projects.show.askEdit') }}
        </router-link>
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
        if (window.confirm(this.$t('pages.projects.show.confirmStop'))) {
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
  }

  .disabled {
    color: #666;
    cursor: not-allowed;
  }

</style>
