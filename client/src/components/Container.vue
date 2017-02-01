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

<style>
.container {
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;

  overflow: hidden;
  text-overflow: ellipsis;
}
.container > * {
  padding: 5px;
}

.container.row {
  display: flex;
}
.container.row.center {
  align-items: center;
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
</style>
