<template>
  <app-header :title="$t('tasks.header.title')">
    <app-header-link to="/tasks/backlog">
      {{ $t('tasks.header.backlog') }}
    </app-header-link>
    <app-header-link to="/tasks/statistics">
      {{ $t('tasks.header.statistics') }}
    </app-header-link>
  </app-header>
</template>
