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

    border-left: 1px solid $ly-color-grey-40;
  }

  @media(max-width: $small-screen-width) {
    .ly-column + .ly-column {
      margin-top: 1rem;
      margin-left: 0;
      padding-top: 2rem;
      padding-left: 0;

      border-top: .25rem solid $ly-color-grey-40;
      border-left: none;
    }
  }
</style>
