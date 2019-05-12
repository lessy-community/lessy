<template>
  <router-link
    :class="['app-menu-link', { 'with-icon': icon }]"
    active-class="active"
    :to="to"
  >
    <ly-icon v-if="icon" :name="icon"></ly-icon>
    <slot></slot>
  </router-link>
</template>

<script>
  export default {
    props: {
      to: { type: [String, Object], required: true },
      icon: { type: String },
    },
  }
</script>

<style lang="scss">
  a.app-menu-link {
    display: block;
    padding: .75rem 2rem;
    margin-bottom: .25rem;

    border-top: .25rem solid transparent;
    border-bottom: .25rem solid transparent;

    @media(max-width: $medium-screen-width) {
      padding-left: 1rem;
      padding-right: 1rem;
    }

    &.with-icon {
      margin-left: -1.5rem;

      @media(max-width: $medium-screen-width) {
        margin-left: 0;
      }
    }
    &:hover,
    &:focus {
      background-color: $ly-color-pine-80;
      border-top-color: $ly-color-pine-70;
      border-bottom-color: $ly-color-pine-70;
    }
    &.active {
      font-weight: bold;

      background-color: $ly-color-pine-80;
      border-top-color: transparent;
      border-bottom-color: transparent;

      &::after {
        content: "\f105";
        font-family: FontAwesome;
        float: right;
      }
    }
  }

  @media(max-width: $small-screen-width) {
    .app-menu-link {
      padding-left: 1rem;
      padding-right: 1rem;

      border-top: none;
      border-bottom: none;

      &:hover,
      &:focus {
        background-color: $ly-color-pine-70;
      }
      &.active {
        background-color: $ly-color-pine-70;
      }

      &.with-icon {
        margin-left: 0;
      }
    }

    .app-menu-link.active::after {
      display: none;
    }
  }
</style>
