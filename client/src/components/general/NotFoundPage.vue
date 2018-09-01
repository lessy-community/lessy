<template>
  <app-page name="not-found" layout="empty">
    <header class="header-not-found" slot="header">
      <div class="header-not-found-container">
        <router-link class="header-not-found-brand" to="/">
          {{ $t('general.notFoundPage.title') }}
        </router-link>
      </div>
    </header>

    <h1>{{ $t('general.notFoundPage.meh') }}</h1>

    <ly-icon name="chain-broken" size="large"></ly-icon>

    <p class="text-secondary">{{ $t('general.notFoundPage.intro') }}</p>

    <router-link to="/">{{ $t('general.notFoundPage.home') }}</router-link>
  </app-page>
</template>

<style lang="scss">
  .app-page-not-found .app-layout-main {
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

  .header-not-found {
    padding: 1rem 2rem;

    background-color: $ly-color-grey-10;
  }

  .header-not-found-container {
    max-width: 80rem;
    margin-left: auto;
    margin-right: auto;
  }

  .header-not-found-brand {
    color: $ly-color-grey-50;
    font-size: 1.2rem;
    font-weight: bold;
    text-decoration: none;
  }
</style>
