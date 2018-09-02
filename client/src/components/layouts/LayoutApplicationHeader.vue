<template>
  <app-header :title="title" fluid>
    <slot v-if="$slots.default" slot="navigation"></slot>
    <user-popover slot="right">
    </user-popover>
  </app-header>
</template>

<script>
  import UserPopover from 'src/components/users/UserPopover'

  export default {
    props: {
      title: { type: String, required: true },
    },

    components: {
      UserPopover,
    },
  }
</script>
