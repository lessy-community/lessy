<template>
  <div :class="['ly-form-group', `ly-form-group-${type}`, { stack }]">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      type: { type: String, default: 'input' },
      stack: { type: Boolean },
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

  .ly-form-group.stack {
    display: flex;

    .ly-form-input {
      flex-grow: 1;
    }

    * + * {
      margin-left: .5rem;
    }
  }
</style>
