<template>
  <a href="#" @click.prevent="action" class="popover-item">
    <slot></slot>
  </a>
</template>

<script>
  export default {

    props: {
      'action': { type: Function, required: true },
    },

  }
</script>

<style lang="scss">
  .popover-item {
    display: block;
    padding: 3px 10px;

    &:hover {
      color: $color-primary-darker;
      text-decoration: none;

      background-color: $color-primary-shadow;
    }
  }
</style>
