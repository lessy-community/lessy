<template>
  <v-popover placement="bottom-end">
    <slot name="toggle"></slot>

    <template slot="popover">
      <slot name="menu"></slot>
    </template>
  </v-popover>
</template>

<script>
  import { VPopover } from 'v-tooltip'

  export default {
    components: {
      VPopover,
    }
  }
</script>

<style lang="scss">
  $popover-arrow-color: $ly-color-grey-60;

  .popover.tooltip {
    .tooltip-inner {
      min-width: 10rem;

      font-size: 1rem;

      background-color: $ly-color-grey-10;
      box-shadow: 0 0 1px $ly-color-grey-90,
                  0 0 3px $ly-color-grey-40,
                  1px 2px 3px $ly-color-grey-60;
    }

    .tooltip-arrow {
      margin: .5rem;
    }

    &[x-placement^="top"] {
      margin-bottom: .5rem;

      .tooltip-arrow {
        border-width: .5rem .5rem 0 .5rem;
        border-color: $popover-arrow-color transparent transparent transparent;
        bottom: -.5rem;
        margin-top: 0;
        margin-bottom: 0;
      }
    }

    &[x-placement^="bottom"] {
      margin-top: .5rem;

      .tooltip-arrow {
        border-width: 0 .5rem .5rem .5rem;
        border-color: transparent transparent $popover-arrow-color transparent;
        top: -.5rem;
        margin-top: 0;
        margin-bottom: 0;
      }
    }

    &[x-placement^="right"] {
      margin-left: .5rem;

      .tooltip-arrow {
        border-width: .5rem .5rem .5rem 0;
        border-color: transparent $popover-arrow-color transparent transparent;
        left: -.5rem;
        margin-left: 0;
        margin-right: 0;
      }
    }

    &[x-placement^="left"] {
      margin-right: .5rem;

      .tooltip-arrow {
        border-width: .5rem 0 .5rem .5rem;
        border-color: transparent transparent transparent $popover-arrow-color;
        right: -.5rem;
        margin-left: 0;
        margin-right: 0;
      }
    }
  }
</style>
