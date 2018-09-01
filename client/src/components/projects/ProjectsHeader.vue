<template>
  <app-header :title="$t('projects.header.title')">
    <app-header-link to="/projects/inbox">
      {{ $t('projects.header.inbox') }}
    </app-header-link>
    <app-header-link v-if="project" :to="project.urlShow">
      {{ $t('projects.header.project') }}
    </app-header-link>
  </app-header>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },
  }
</script>
