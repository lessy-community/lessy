<template>
  <app-layout name="projects">
    <default-menu slot="menu"></default-menu>
    <app-header slot="header" :title="$t('projects.layout.title')">
      <app-header-link to="/projects/inbox">
        {{ $t('projects.layout.inbox') }}
      </app-header-link>
      <app-header-link v-if="project" :to="project.urlShow">
        {{ $t('projects.layout.project') }}
      </app-header-link>
    </app-header>
    <router-view></router-view>
  </app-layout>
</template>

<script>
  import { mapGetters } from 'vuex'

  import DefaultMenu from 'src/components/general/DefaultMenu'

  export default {
    components: {
      DefaultMenu,
    },

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },
  }
</script>
