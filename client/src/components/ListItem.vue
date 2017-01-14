<template>
  <div class="list-item">
    <slot></slot>
  </div>
</template>

<script>
  export default {

    name: 'list-item',

  }
</script>

<style>

  .list-item {
    display: block;

    line-height: 1.4rem;
  }
  .list-item > a {
    display: block;
    padding: 10px 15px;

    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;

    border-radius: 4px;

    transition: all .1s ease-in-out;
  }
  .list-item > a:hover {
    color: #000;
    background-color: #e2f4fb;
  }

</style>
