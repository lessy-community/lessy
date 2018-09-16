<template>
  <app-page name="not-found" layout="empty" centered>
    <h1>{{ $t('general.notFoundPage.title') }}</h1>

    <ly-icon name="chain-broken" size="large"></ly-icon>

    <p class="text-secondary">{{ $t('general.notFoundPage.intro') }}</p>

    <router-link to="/">{{ $t('general.notFoundPage.home') }}</router-link>
  </app-page>
</template>

<style lang="scss">
  .app-page-not-found .app-layout-main {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);

    > .text-secondary {
      margin-top: 1.5rem;
    }
  }
</style>
