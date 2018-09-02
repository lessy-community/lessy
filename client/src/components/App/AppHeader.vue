<template>
  <header class="app-header">
    <div class="app-header-container">
      <router-link v-if="brand" to="/" class="app-header-brand">
        {{ brand }}
      </router-link>
    </div>
  </header>
</template>

<script>
  export default {
    props: {
      brand: { type: String },
    },
  }
</script>

<style lang="scss">
  .app-header {
    padding: 1rem 2rem;

    background-color: $ly-color-grey-20;
  }

  .app-header-container {
    max-width: 80rem;
    margin-left: auto;
    margin-right: auto;
  }

  .app-header-brand {
    color: $ly-color-grey-90;
    font-size: 1.2rem;
    font-weight: bold;
    text-decoration: none;
  }
</style>
