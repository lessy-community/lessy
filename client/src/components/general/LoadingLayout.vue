<template>
  <app-layout name="loading">
    <default-menu slot="menu"></default-menu>

    <app-page name="loading">
      <h1>{{ $t('general.loadingLayout.inProgress') }}</h1>
    </app-page>
  </app-layout>
</template>

<script>
  import AppLayout from 'src/components/App/AppLayout'
  import AppPage from 'src/components/App/AppPage'
  import DefaultMenu from './DefaultMenu'

  export default {
    components: {
      AppLayout,
      AppPage,
      DefaultMenu,
    },
  }
</script>
