<template>
  <div :class="['ly-form-group', `ly-form-group-${type}`]">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      type: { type: String, default: 'input' },
    },
  }
</script>

<style lang="scss">
  .ly-form-group {
    margin-top: .5rem;
    margin-bottom: 1rem;
  }
  .ly-form-group-actions-block {
    text-align: center;

    > .ly-button,
    > a {
      display: block;
      width: 100%;
      margin-bottom: .5rem;
    }
  }
</style>
