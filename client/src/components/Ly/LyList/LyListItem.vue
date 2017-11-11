<template>
  <div :class="['ly-list-item', { [`ly-list-item-${name}`]: name }]">
    <span v-if="withHandle" class="my-handle">::</span>

    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      name: { type: String },
      'with-handle': { type: Boolean },
    },
  }
</script>

<style lang="scss">
  .ly-list-item {
    display: flex;
    padding: .5rem .5rem;

    align-items: center;

    overflow: hidden;
    text-overflow: ellipsis;

    .my-handle {
      padding: .25rem;
      visibility: hidden;
      cursor: move;
    }
    &:hover .my-handle {
      visibility: visible;
    }

    &:nth-child(even) {
      background-color: $ly-color-grey-20;
    }

    > * {
      flex-shrink: 0;
    }

    > * + * {
      margin-left: .25rem;
      margin-right: 0;
    }
  }

  @media(max-width: $small-screen-width) {
    .ly-list-item {
      padding: 1rem .5rem;

      flex-direction: column;
      align-items: stretch;

      .my-handle {
        display: none;
      }
    }
  }
</style>
