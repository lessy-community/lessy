<template>
  <app-layout name="design" no-tos-requirement>
    <design-menu slot="menu"></design-menu>
    <router-view></router-view>
  </app-layout>
</template>

<script>
  import DesignMenu from './DesignMenu'

  export default {
    components: {
      DesignMenu,
    },
  }
</script>
