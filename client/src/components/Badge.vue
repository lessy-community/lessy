<template>
  <div class="badge">
    <slot></slot>
  </div>
</template>

<script>
  export default {
  }
</script>

<style lang="scss">
  .badge {
    display: inline-block;
    margin-left: 5px;
    padding: 1px 5px;

    color: #444;
    font-size: .9rem;

    background-color: #ddd;
    border: 1px solid #ccc;
    border-radius: 3px;
  }
</style>
