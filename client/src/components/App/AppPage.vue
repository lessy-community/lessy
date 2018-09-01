<template>
  <section v-if="layout" :class="['app-page', `app-page-${name}`]">
    <component :is="`layout-${layout}`">
      <slot name="menu" slot="menu"></slot>
      <slot name="header" slot="header"></slot>
      <slot></slot>
    </component>
  </section>
  <main v-else :class="['app-page', 'legacy', `app-page-${name}`]">
    <slot></slot>
  </main>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
      layout: { type: String },
    },
  }
</script>

<style lang="scss">
  .app-page.legacy {
    padding-top: 1rem;
    padding-left: 2rem;
    padding-right: 2rem;
    padding-bottom: 5rem;

    background-color: $ly-color-grey-10;
  }
  .app-header + .app-page.legacy {
    border-radius: .25rem 0 0 0;
  }

  @media(max-width: $small-screen-width) {
    .app-page.legacy {
      padding-left: 1rem;
      padding-right: 1rem;
    }
    .app-header + .app-page.legacy {
      border-radius: 0;
    }
  }
</style>
