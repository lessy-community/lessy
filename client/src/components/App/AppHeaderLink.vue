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
    color: $ly-color-white;
    text-decoration: none;

    opacity: .7;
    transition: opacity .2s ease-in-out;

    &:hover {
      color: $ly-color-white;

      opacity: 1;
    }
    &:focus {
      color: $ly-color-white;
    }
    &.active {
      font-weight: bold;

      opacity: 1;
    }

    + .app-header-link::before {
      padding-left: .5rem;
      padding-right: .5rem;

      content: "·";
    }
  }
</style>
