<template>
  <app-layout name="tasks">
    <default-menu slot="menu"></default-menu>
    <app-header slot="header" :title="$t('tasks.layout.title')">
      <app-header-link to="/tasks/backlog">
        {{ $t('tasks.layout.backlog') }}
      </app-header-link>
      <app-header-link to="/tasks/statistics">
        {{ $t('tasks.layout.statistics') }}
      </app-header-link>
    </app-header>
    <router-view></router-view>
  </app-layout>
</template>

<script>
  import DefaultMenu from 'src/components/general/DefaultMenu'

  export default {
    components: {
      DefaultMenu,
    },
  }
</script>
