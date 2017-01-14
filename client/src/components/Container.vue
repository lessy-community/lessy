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
  max-width: 950px;
  margin-left: auto;
  margin-right: auto;
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
.container.row .separator {
  flex-grow: 1;
  flex-shrink: 1;
}
</style>
