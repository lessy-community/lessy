<template>
  <div :class="['badge', { warn, alert }]">
    <slot></slot>
  </div>
</template>

<script>
  export default {

    props: {
      'warn': { type: Boolean },
      'alert': { type: Boolean },
    },

  }
</script>

<style lang="scss">
  .badge {
    display: inline-block;
    margin-left: 5px;
    padding: 2px 6px;

    color: #444;
    font-size: .9rem;

    background-color: #ccc;
    border-radius: 3px;

    &.warn {
      color: #fff;
      background-color: lighten($color-danger, 15%);
    }
    &.alert {
      color: #fff;
      background-color: $color-danger;
    }
  }
</style>
