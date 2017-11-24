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
</style>
