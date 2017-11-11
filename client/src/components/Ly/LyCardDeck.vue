<template>
  <div :class="['ly-card-deck', { [`ly-card-deck-${name}`]: name }]">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      name: { type: String },
    },
  }
</script>

<style lang="scss">
  .ly-card-deck {
    display: flex;
    margin-left: -.5rem;
    margin-right: -.5rem;

    flex-wrap: wrap;

    > .ly-card {
      flex: 1 0 0;

      margin-left: .5rem;
      margin-right: .5rem;
    }
  }

  @media(max-width: $small-screen-width) {
    .ly-card-deck {
      flex-wrap: nowrap;
      flex-direction: column;

      > .ly-card {
        flex: 0 1 auto;
      }
    }
  }
</style>
