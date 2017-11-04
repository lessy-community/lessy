<template>
  <main :class="['app-page', `app-page-${name}`]">
    <slot></slot>
  </main>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
    },
  }
</script>

<style lang="scss">
  .app-page {
    padding-top: 1rem;
    padding-left: 2rem;
    padding-right: 2rem;
    padding-bottom: 5rem;

    background-color: $ly-color-grey-10;
  }
  .app-header + .app-page {
    border-radius: .25rem 0 0 0;
  }

  @media(max-width: $small-screen-width) {
    .app-page {
      padding-left: 1rem;
      padding-right: 1rem;
    }
    .app-header + .app-page {
      border-radius: 0;
    }
  }
</style>
