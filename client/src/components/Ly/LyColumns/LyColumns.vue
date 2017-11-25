<template>
  <div :class="['ly-columns', {
    [`ly-columns-${name}`]: name,
    bordered,
  }]">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      name: { type: String },
      bordered: { type: Boolean },
    },
  }
</script>

<style lang="scss">
  .ly-columns {
    display: flex;

    align-items: stretch;

    > .ly-column {
      flex: 1 1 0;
    }

    &.bordered .ly-column + .ly-column {
      border-left: 1px solid $ly-color-grey-40;
    }
  }

  @media(max-width: $small-screen-width) {
    .ly-columns {
      flex-direction: column;

      &.bordered .ly-column + .ly-column {
        border-top: .25rem solid $ly-color-grey-40;
        border-left: none;
      }
    }
  }
</style>
