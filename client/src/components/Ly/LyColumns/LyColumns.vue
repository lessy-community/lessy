<template>
  <div class="ly-columns">
    <slot></slot>
  </div>
</template>

<style lang="scss">
  .ly-columns {
    display: flex;

    align-items: stretch;

    > .ly-column {
      flex: 1 1 0;
    }
  }

  @media(max-width: $small-screen-width) {
    .ly-columns {
      flex-direction: column;
    }
  }
</style>
