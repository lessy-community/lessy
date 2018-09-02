<template>
  <router-link v-if="to" :to="to" class="ly-popover-item">
    <slot></slot>
  </router-link>
  <a v-else href="#" @click.prevent="$emit('click')" class="ly-popover-item">
    <slot></slot>
  </a>
</template>

<script>
  export default {
    props: {
      to: { type: String },
    },
  }
</script>

<style lang="scss">
  .ly-popover-item {
    display: block;
    padding: .25rem .5rem;

    color: $ly-color-grey-90;
    text-decoration: none;

    border-radius: .25rem;

    transition: all .2s ease-in-out;

    &:hover {
      background-color: $ly-color-grey-20;
      box-shadow: 0 0 1px $ly-color-grey-50;
    }
  }
</style>
