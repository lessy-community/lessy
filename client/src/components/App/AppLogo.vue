<template>
  <div :class="['app-logo', `flavour-${flavour}`, `size-${size}`, { 'with-brand': !nobrand }]">
    <img v-if="flavour === 'inversed'" alt="" src="/static/logo-inverse.svg" />
    <img v-else-if="flavour === 'black'" alt="" src="/static/logo-black.svg" />
    <img v-else alt="" src="/static/logo.svg" />
    <span v-if="!nobrand">Lessy</span>
  </div>
</template>

<script>
  export default {
    props: {
      flavour: { type: String, default: 'normal' },
      size: { type: String, default: 'small' },
      nobrand: { type: Boolean },
    },
  }
</script>

<style lang="scss">
  .app-logo {
    padding: .25em;

    color: $ly-color-pine-70;
    font-family: 'Permanent Marker', cursive;

    img {
      width: 1em;
      height: 1em;
    }

    span {
      line-height: 1em;
    }

    &.size-small {
      font-size: 1.75rem;
    }
    &.size-large {
      font-size: 7rem;
    }
    @media(max-width: $small-screen-width) {
      &.size-large {
        font-size: 5rem;
      }
    }

    &.flavour-inversed {
      color: $ly-color-white;

      background-color: $ly-color-pine-70;
      border-radius: .25rem;
    }
    &.flavour-black {
      color: $ly-color-grey-90;
    }

    &.with-brand {
      display: flex;
      padding-left: 0;
      padding-right: 0;
      align-items: stretch;
    }
  }
</style>
