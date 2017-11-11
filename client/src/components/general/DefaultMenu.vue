<template>
  <app-menu title="Lessy">
    <app-menu-link to="/dashboard" icon="tachometer">{{ $t('general.defaultMenu.dashboard') }}</app-menu-link>
    <app-menu-link to="/tasks" icon="check-circle">{{ $t('general.defaultMenu.tasks') }}</app-menu-link>
    <app-menu-link to="/projects" icon="folder-open">{{ $t('general.defaultMenu.projects') }}</app-menu-link>
  </app-menu>
</template>

<script>
  import AppMenu from 'src/components/App/AppMenu'
  import AppMenuLink from 'src/components/App/AppMenuLink'

  export default {
    components: {
      AppMenu,
      AppMenuLink,
    },
  }
</script>
