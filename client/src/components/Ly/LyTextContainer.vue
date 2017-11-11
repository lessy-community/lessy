<template>
  <div :class="['ly-text-container', { margined }]">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      margined: { type: Boolean },
    },
  }
</script>

<style lang="scss">
  .ly-text-container {
    display: block;
    max-width: 30rem;
    padding-bottom: 1rem;

    word-wrap: break-word;

    &.margined {
      margin-left: auto;
      margin-right: auto;
    }

    &:last-child {
      padding-bottom: 0;
    }
  }
</style>
