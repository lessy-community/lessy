<template>
  <router-link class="app-header-link" active-class="active" :to="to">
    <slot></slot>
  </router-link>
</template>

<script>
  export default {
    props: {
      to: { type: [String, Object], required: true },
    },
  }
</script>

<style lang="scss">
  .app-header-link {
    padding-left: 1rem;
    padding-right: 1rem;

    text-decoration: none;

    &.active {
      text-decoration: underline;
    }
  }
</style>
