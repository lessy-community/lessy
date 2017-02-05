<template>
  <div class="tabs">
    <slot></slot>
  </div>
</template>

<script>
  export default {

    name: 'tabs',

  }
</script>

<style>

  .tabs {
    display: flex;
    align-items: stretch;
    margin-bottom: 10px;

    border-bottom: 1px solid #ddd;
  }

  .tabs a {
    padding: 10px 20px;
  }
  .tabs a:hover {
    color: #000;
    text-decoration: none;
  }
  .tabs a.active {
    color: #000;
    font-weight: bold;
  }

</style>
