<template>
  <layout-application-header :title="$t('projects.header.title')">
    <app-header-link to="/projects/inbox">{{ $t('projects.header.inbox') }}</app-header-link>
    <app-header-link v-if="project" :to="project.urlShow">{{ $t('projects.header.project') }}</app-header-link>
  </layout-application-header>
</template>

<script>
  import { mapGetters } from 'vuex'

  import LayoutApplicationHeader from 'src/components/layouts/LayoutApplicationHeader'

  export default {
    components: {
      LayoutApplicationHeader,
    },

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },
  }
</script>
