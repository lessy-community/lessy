<template>
  <section :class="['ly-section', { [`ly-section-${name}`]: name }]">
    <header class="ly-section-header">
      <h2>{{ title }}</h2>
      <div class="ly-section-header-break"></div>
    </header>
    <slot></slot>
  </section>
</template>

<script>
  export default {
    props: {
      'title': { type: String, required: true },
      'name': { type: String },
    },
  }
</script>

<style lang="scss">
  .ly-section {
    padding-bottom: 2rem;
  }

  .ly-section-header {
    display: flex;
    padding-bottom: .5rem;

    align-items: center;

    h2 {
      margin-bottom: 0;

      font-size: 1rem;
    }

    .ly-section-header-break {
      margin-left: 2rem;

      flex-grow: 1;

      border-bottom: 1px solid $ly-color-grey-50;
    }
  }

  @media(max-width: $small-screen-width) {
  }
</style>
