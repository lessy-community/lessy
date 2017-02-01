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
  .list-item > * {
    display: block;
    padding: 10px 15px;

    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;

    border: 1px solid transparent;
    border-radius: 4px;

    transition: all .1s ease-in-out;
  }
  .list-item > a:hover {
    color: #000;
    text-decoration: none;

    background-color: #e2f4fb;
  }
  .list-item > a.active {
    color: #000;
    font-weight: bold;
  }

</style>
