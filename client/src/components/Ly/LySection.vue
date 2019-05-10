<template>
  <section :class="['ly-section', { [`ly-section-${name}`]: name }]">
    <header class="ly-section-header">
      <h2>{{ title }}</h2>
      <div class="ly-section-header-break"></div>
    </header>

    <div v-if="$slots.actions" class="ly-section-actions">
      <slot name="actions">
      </slot>
    </div>

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

  .ly-section-actions {
    padding-top: 1rem;
    padding-bottom: 1rem;
    margin-top: -.5rem;
    margin-bottom: 1rem;

    text-align: center;

    .ly-form {
      margin-left: auto;
      margin-right: auto;

      text-align: left;
    }
  }
</style>
