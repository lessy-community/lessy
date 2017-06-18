<template>
  <container row class="app-content">
    <app-sidebar v-if="sidebar"></app-sidebar>
    <div :class="['app-body', 'adapt', contentClass]">
      <slot></slot>
    </div>
  </container>
</template>

<script>
  import AppSidebar from './AppSidebar'

  export default {

    name: 'app-content',

    props: {
      'sidebar': { type: Boolean },
      'contentClass': { type: String },
    },

    components: {
      AppSidebar,
    },

  }
</script>

<style lang="scss">

  .app-content {
    min-height: calc(100vh - 66px);
    margin-top: -10px;
  }

  .app-body {
    padding: 25px;

    background-color: #fff;
    border-left: 1px solid #eee;
    border-right: 1px solid #eee;
  }

  @media(max-width: $small-screen-width) {
    .app-body {
      padding: 5px;
    }
  }

</style>
