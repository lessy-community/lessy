<template>
  <ly-card-deck name="projects">
    <project-card
      v-for="project in projects"
      :key="project.id"
      :project="project"
    ></project-card>
    <ly-card v-for="i in (3 - projects.length)" type="placeholder">
      {{ $t('projects.cardDeck.empty') }}<br />
      <small>
        <router-link to="/projects/inbox">
          {{ $t('projects.cardDeck.emptyLink') }}
        </router-link>
      </small>
    </ly-card>
  </ly-card-deck>
</template>

<script>
  import ProjectCard from './ProjectCard'

  export default {
    props: {
      projects: { type: Array, required: true },
    },

    components: {
      ProjectCard,
    },
  }
</script>

<style>
  .ly-card-deck-projects .ly-card-placeholder {
    min-height: 7rem;
  }
</style>
