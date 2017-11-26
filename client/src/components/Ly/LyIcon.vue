<template>
  <i :class="['ly-icon', 'fa', 'fa-fw',  `fa-${name}`, {
    'fa-spin': spin,
    [`ly-icon-${size}`]: size,
  }]" aria-hidden="true"></i>
</template>

<script>
  export default {
    props: {
      'name': { type: String, required: true },
      'size': { type: String, default: 'normal' },
      'spin': { type: Boolean },
    },
  }
</script>

<style lang="scss">
  .ly-icon {
    width: 1.5em;

    line-height: 1.5em;

    &.ly-icon-large {
      vertical-align: middle;

      font-size: 1.75em;
    }
  }
</style>
