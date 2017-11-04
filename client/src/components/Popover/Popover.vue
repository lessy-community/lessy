<template>
  <div :class="['popover', { opened: showMenu }]">
    <a href="#" class="popover-toggle" @click.prevent="toggleMenu">
      <slot name="toggle"></slot>
    </a>

    <div v-if="showMenu" class="popover-menu">
      <slot name="menu"></slot>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        showMenu: false,
      }
    },

    methods: {
      toggleMenu () {
        this.showMenu = !this.showMenu
      },
    },
  }
</script>

<style lang="scss">
  .popover.opened .popover-toggle::before {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;

    content: '';
    cursor: default;
  }

  .popover-toggle {
    display: inline-block;
  }

  .popover-menu {
    position: absolute;

    min-width: 150px;
    max-width: 250px;
    margin-top: 5px;
    margin-left: -95px;
    padding-top: 3px;
    padding-bottom: 3px;

    background: #fff;
    border: 1px solid #ddd;
    border-radius: 3px;
    box-shadow: 0 0 2px #ddd;
  }
</style>
