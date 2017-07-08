<template>
  <app-content sidebar contentClass="tasks-layout">
    <tabs>
      <router-link to="/tasks/backlog" activeClass="active">{{ $t('layout.tasks.backlog') }}</router-link>
    </tabs>
    <router-view></router-view>
  </app-content>
</template>
