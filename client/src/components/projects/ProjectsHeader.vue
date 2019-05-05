<template>
  <app-header :title="$t('projects.header.title')" fluid>
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
