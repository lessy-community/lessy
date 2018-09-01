<template>
  <app-page name="loading" layout="empty">
    <header class="header-loading" slot="header">
      <div class="header-loading-container">
        <router-link class="header-loading-brand" to="/">
          {{ $t('general.loadingPage.title') }}
        </router-link>
      </div>
    </header>

    <h1>{{ $t('general.loadingPage.inProgress') }}</h1>

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

  .header-loading {
    padding: 1rem 2rem;

    background-color: $ly-color-grey-10;
  }

  .header-loading-container {
    max-width: 80rem;
    margin-left: auto;
    margin-right: auto;
  }

  .header-loading-brand {
    color: $ly-color-grey-50;
    font-size: 1.2rem;
    font-weight: bold;
    text-decoration: none;
  }
</style>
