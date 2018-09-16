<template>
  <a
    v-if="selectable"
    href="#"
    @click.prevent="$emit('select')"
    :class="['ly-list-item', 'selectable', { [`ly-list-item-${name}`]: name }]"
  >
    <slot></slot>
  </a>
  <div v-else :class="['ly-list-item', { [`ly-list-item-${name}`]: name }]">
    <span v-if="withHandle" class="my-handle">::</span>

    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      name: { type: String },
      'with-handle': { type: Boolean },
      selectable: { type: Boolean },
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

    > * {
      flex-shrink: 0;
    }

    > * + * {
      margin-left: .25rem;
      margin-right: 0;
    }

    &.selectable {
      color: $ly-color-grey-90;
      text-decoration: none;

      border: 1px solid transparent;
      border-radius: .25rem;
    }
    &.selectable:hover {
      border-color: $ly-color-pine-50;
      box-shadow: 0 0 1px $ly-color-pine-50 inset;
    }
    &.selectable:focus {
      border-color: $ly-color-pine-50;
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
