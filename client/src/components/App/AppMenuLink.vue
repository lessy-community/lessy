<template>
  <router-link :class="['app-menu-link', { 'with-icon': icon }]" active-class="active" :to="to">
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
  .app-menu-link {
    display: block;
    padding: .75rem 2rem;

    opacity: .7;
    transition: opacity .2s ease-in-out;

    &.with-icon {
      margin-left: -1.5rem;
    }
    &:hover {
      opacity: 1;
    }
    &.active {
      font-weight: bold;

      opacity: 1;

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

      opacity: 1;
      transition: background .2s ease-in-out;

      &:hover,
      &:focus {
        background-color: $ly-color-pine-60;
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
