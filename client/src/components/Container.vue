<template>
  <div :class="['container', align, { row }]">
    <slot></slot>
  </div>
</template>

<script>
export default {
  name: 'container',
  props: {
    'row': { type: Boolean },
    'align': { type: String },
  },
}
</script>

<style lang="scss">
  .container {
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .container.row {
    display: flex;
  }
  .container.row.center {
    align-items: center;
  }
  .container.row.baseline {
    align-items: baseline;
  }
  .container.row > * {
    flex-shrink: 0;
  }
  .container.row > .adapt {
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .container.row > .adapt,
  .container.row > .separator {
    flex-grow: 1;
    flex-shrink: 1;
  }

  @media(max-width: $small-screen-width) {
    .container.row {
      flex-direction: column;

      > * {
        margin-bottom: 5px;
      }
    }
  }
</style>
