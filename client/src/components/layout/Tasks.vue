<template>
  <app-content sidebar contentClass="tasks-layout">
    <tabs>
      <router-link to="/tasks/planning" activeClass="active">{{ $t('layout.tasks.planning') }}</router-link>
    </tabs>
    <router-view></router-view>
  </app-content>
</template>

<script>
  export default {

    name: 'tasks-layout',

  }
</script>
