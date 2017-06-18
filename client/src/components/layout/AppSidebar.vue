<template>
  <div class="app-sidebar">
    <router-link to="/dashboard" active-class="active">{{ $t('layout.sidebar.dashboard') }}</router-link>
    <router-link to="/tasks" active-class="active">{{ $t('layout.sidebar.tasks') }}</router-link>
    <router-link to="/projects" active-class="active">{{ $t('layout.sidebar.projects') }}</router-link>
  </div>
</template>

<script>
  export default {

    name: 'app-sidebar',

  }
</script>

<style lang="scss">

  .app-sidebar {
    width: 230px;
    padding-top: 25px;
    padding-left: 5px;
    padding-right: 5px;
  }
  .app-sidebar > a {
    display: block;
    padding: 10px 15px;

    transition: all .1s ease-in-out;
  }
  .app-sidebar > a:hover {
    color: #000;
    text-decoration: none;
  }
  .app-sidebar a.active {
    color: #000;
    font-weight: bold;
  }

  @media(max-width: $small-screen-width) {
    .app-sidebar {
      display: none;
      width: auto;
      padding-top: 5px;
      padding-bottom: 5px;

      background-color: #eaeaea;
      border-bottom: 1px solid #ddd;
    }

    .with-app-sidebar .app-sidebar {
      display: block;
    }
  }

</style>
