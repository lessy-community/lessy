<template>
  <div class="ly-column">
    <slot></slot>
  </div>
</template>

<style lang="scss">
  .ly-column {
    padding-top: 1rem;
    padding-bottom: 1rem;
  }
  .ly-column + .ly-column {
    margin-left: 2rem;
    padding-left: 2rem;
  }

  @media(max-width: $small-screen-width) {
    .ly-column + .ly-column {
      margin-top: 1rem;
      margin-left: 0;
      padding-top: 2rem;
      padding-left: 0;
    }
  }
</style>
