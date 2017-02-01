<template>
  <div class="app-sidebar">
    <list-item>
      <router-link to="/dashboard" active-class="active">{{ $t('layout.sidebar.dashboard') }}</router-link>
    </list-item>
    <list-item>
      <router-link to="/projects/inbox" active-class="active">{{ $t('layout.sidebar.projectsInbox') }}</router-link>
    </list-item>
  </div>
</template>

<script>
  export default {

    name: 'app-sidebar',

  }
</script>

<style>

  .container > .app-sidebar {
    width: 230px;
    padding-top: 25px;
  }
  .app-sidebar .list-item > a:hover {
    background-color: transparent;
  }
  .app-sidebar .list-item > a:not(.active):hover {
    border: 1px solid #ddd;
  }

</style>
