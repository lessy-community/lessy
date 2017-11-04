<template>
  <app-layout name="dashboard">
    <default-menu slot="menu"></default-menu>
    <app-header slot="header" :title="$t('dashboard.layout.title')"></app-header>
    <dashboard-page></dashboard-page>
  </app-layout>
</template>

<script>
  import DefaultMenu from 'src/components/general/DefaultMenu'
  import DashboardPage from './DashboardPage'

  export default {
    components: {
      DefaultMenu,
      DashboardPage,
    },
  }
</script>
