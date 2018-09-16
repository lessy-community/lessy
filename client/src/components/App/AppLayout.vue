<template>
  <div :class="['app-layout', `app-layout-${name}`]">
    <slot name="menu"></slot>
    <div class="app-layout-container">
      <slot name="header"></slot>
      <main :class="['app-layout-main', { centered }]">
        <slot></slot>
      </main>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
      centered: { type: Boolean },
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
    > .app-layout-container {
      flex-grow: 1;
    }
  }

  .app-layout-container {
    display: flex;
    flex-direction: column;

    > .app-layout-main {
      flex-grow: 1;
    }
  }

  .app-layout-main {
    padding-top: 1rem;
    padding-bottom: 5rem;
    padding-left: 2rem;
    padding-right: 2rem;

    background-color: $ly-color-grey-10;

    &.centered {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-layout {
      flex-direction: column;

      > .app-menu {
        width: auto;
      }
    }

    .app-layout-main {
      padding-left: 1rem;
      padding-right: 1rem;
    }
  }
</style>
