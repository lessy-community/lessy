<template>
  <app-header :title="$t('projects.header.title')" nobrand fluid>
    <user-popover slot="right">
    </user-popover>
  </app-header>
</template>

<script>
  import UserPopover from '@/components/users/UserPopover'

  export default {
    components: {
      UserPopover,
    },
  }
</script>
