<template>
  <div :class="['container', { row }]">
    <slot></slot>
  </div>
</template>

<script>
export default {
  name: 'container',
  props: {
    'row': { type: Boolean },
  },
}
</script>

<style>
.container {
  max-width: 950px;
  margin-left: auto;
  margin-right: auto;
}
.container.row {
  display: flex;
}
.container.row > * {
  flex-shrink: 0;
}
.container.row .separator {
  flex-grow: 1;
  flex-shrink: 1;
}
</style>
