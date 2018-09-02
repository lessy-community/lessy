<template>
  <app-page name="loading" layout="empty">
    <h1>{{ $t('general.loadingPage.title') }}</h1>

    <ly-icon name="circle-o-notch" size="large" spin></ly-icon>

    <p class="text-secondary">{{ $t('general.loadingPage.wait') }}</p>
  </app-page>
</template>

<style lang="scss">
  .app-page-loading .app-layout-main {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

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
