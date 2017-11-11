<template>
  <div class="ly-list-item-adapt">
    <slot></slot>
  </div>
</template>

<style>
  .ly-list-item > .ly-list-item-adapt {
    flex-grow: 1;
    flex-shrink: 1;
  }
</style>
