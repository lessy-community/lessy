<template>
  <app-page name="not-found" layout="default">
    <ly-text-container margined>
      <h1>{{ $t('general.notFoundPage.title') }}</h1>
      <p>{{ $t('general.notFoundPage.intro') }}</p>
      <router-link to="/">{{ $t('general.notFoundPage.home') }}</router-link>
    </ly-text-container>
  </app-page>
</template>
