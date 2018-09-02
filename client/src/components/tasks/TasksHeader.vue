<template>
  <layout-application-header :title="$t('tasks.header.title')">
    <app-header-link to="/tasks/backlog">
      {{ $t('tasks.header.backlog') }}
    </app-header-link>
    <app-header-link to="/tasks/statistics">
      {{ $t('tasks.header.statistics') }}
    </app-header-link>
  </layout-application-header>
</template>

<script>
  import LayoutApplicationHeader from 'src/components/layouts/LayoutApplicationHeader'

  export default {
    components: {
      LayoutApplicationHeader,
    },
  }
</script>
