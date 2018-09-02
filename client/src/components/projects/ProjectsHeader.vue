<template>
  <app-header :title="$t('projects.header.title')" fluid>
    <template slot="navigation">
      <app-header-link to="/projects/inbox">{{ $t('projects.header.inbox') }}</app-header-link>
      <app-header-link v-if="project" :to="project.urlShow">{{ $t('projects.header.project') }}</app-header-link>
    </template>

    <user-popover slot="right">
    </user-popover>
  </app-header>
</template>

<script>
  import { mapGetters } from 'vuex'

  import UserPopover from 'src/components/users/UserPopover'

  export default {
    components: {
      UserPopover,
    },

    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },
  }
</script>
