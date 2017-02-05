<template>
  <app-content sidebar contentClass="projects-layout">
    <tabs>
      <router-link to="/projects" activeClass="active">{{ $t('layout.projects.inbox') }}</router-link>
    </tabs>
    <router-view></router-view>
  </app-content>
</template>

<script>
  export default {

    name: 'tasks-layout',

  }
</script>
