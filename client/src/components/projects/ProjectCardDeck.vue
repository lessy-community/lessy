<template>
  <ly-card-deck name="projects">
    <project-card
      v-for="project in projects"
      :key="project.id"
      :project="project"
    ></project-card>
    <ly-card v-for="i in (3 - projects.length)" type="placeholder">
      <p>{{ $t('projects.cardDeck.empty') }}</p>
      <ly-button
        size="small"
        @click="activeModal = 'start'"
      >
        {{ $t('projects.cardDeck.emptyLink') }}
      </ly-button>
    </ly-card>

    <projects-start-new-modal
      v-if="activeModal === 'start'"
      @close="activeModal = null"
    ></projects-start-new-modal>
  </ly-card-deck>
</template>

<script>
  import ProjectCard from './ProjectCard'
  import ProjectsStartNewModal from './ProjectsStartNewModal'

  export default {
    props: {
      projects: { type: Array, required: true },
    },

    components: {
      ProjectCard,
      ProjectsStartNewModal,
    },

    data () {
      return {
        activeModal: null,
      }
    },
  }
</script>

<style>
  .ly-card-deck-projects .ly-card-placeholder {
    min-height: 7rem;
  }
</style>
