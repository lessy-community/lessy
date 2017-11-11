<template>
  <section :class="['app-layout', `app-layout-${name}`]">
    <slot name="menu"></slot>
    <div class="app-page-container">
      <slot name="header"></slot>
      <slot></slot>
    </div>
  </section>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
    },
  }
</script>

<style lang="scss">
  .app-layout {
    display: flex;
    min-height: 100vh;

    align-items: stretch;

    > .app-menu {
      width: 15rem;

      flex-shrink: 0;
    }
    > .app-page-container {
      flex-grow: 1;
    }
  }

  .app-page-container {
    display: flex;
    flex-direction: column;

    > .app-page {
      flex-grow: 1;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-layout {
      flex-direction: column;

      > .app-menu {
        width: auto;
      }
    }
  }
</style>
