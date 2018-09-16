<template>
  <app-layout name="empty" :centered="centered">
    <slot name="menu" slot="menu"></slot>
    <app-header slot="header" :brand="$t('layouts.empty.brand')">
    </app-header>
    <slot></slot>
  </app-layout>
</template>

<script>
  export default {
    props: {
      centered: { type: Boolean },
    },
  }
</script>

<style lang="scss">
  .app-layout-empty {
    .app-layout-main,
    .app-header {
      background-color: $ly-color-grey-10;
    }

    .app-header-brand {
      color: $ly-color-grey-50;
    }
  }
</style>
