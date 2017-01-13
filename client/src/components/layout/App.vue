<template>
  <div id="app">
    <app-header></app-header>
    <container>
      <router-view></router-view>
    </container>
  </div>
</template>

<script>
import AppHeader from './AppHeader'

export default {
  name: 'app',
  components: {
    AppHeader,
  },
}
</script>

<style>
* {
  box-sizing: border-box;
}

html,
body {
  margin: 0;
  padding: 0;
}
</style>
