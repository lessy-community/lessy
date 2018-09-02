<template>
  <app-header :title="$t('tasks.header.title')" fluid>
    <template slot="navigation">
      <app-header-link to="/tasks/backlog">{{ $t('tasks.header.backlog') }}</app-header-link>
      <app-header-link to="/tasks/statistics">{{ $t('tasks.header.statistics') }}</app-header-link>
    </template>

    <user-popover slot="right">
    </user-popover>
  </app-header>
</template>

<script>
  import UserPopover from 'src/components/users/UserPopover'

  export default {
    components: {
      UserPopover,
    },
  }
</script>
