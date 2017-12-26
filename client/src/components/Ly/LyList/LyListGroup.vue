<template>
  <div class="ly-list-group">
    <div class="ly-list-group-header">{{ name }}</div>
    <div class="ly-list-group-body">
      <slot></slot>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
    },
  }
</script>

<style lang="scss">
  .ly-list-group {
    display: flex;

    + .ly-list-group {
      margin-top: calc(1rem - 1px);
      padding-top: 1rem;

      border-top: 1px solid $ly-color-grey-30;
    }

    > .ly-list-group-body {
      flex-grow: 1;
    }
  }
  .ly-list-group-header {
    width: 2rem;
    padding: .5rem;

    color: $ly-color-grey-50;
  }

  @media(max-width: $small-screen-width) {
    .ly-list-group-header {
      padding: 1rem .5rem;
    }
  }
</style>
