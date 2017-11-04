<template>
  <app-layout name="design">
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
