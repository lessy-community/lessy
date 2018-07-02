<template>
  <app-layout name="not-found" no-tos-requirement>
    <welcome-header slot="header"></welcome-header>
    <app-page name="not-found">
      <ly-text-container margined>
        <h1>{{ $t('general.notFoundLayout.title') }}</h1>
        <p>{{ $t('general.notFoundLayout.intro') }}</p>
        <router-link to="/">{{ $t('general.notFoundLayout.home') }}</router-link>
      </ly-text-container>
    </app-page>
  </app-layout>
</template>

<script>
  import WelcomeHeader from 'src/components/general/WelcomeHeader'

  export default {
    components: {
      WelcomeHeader,
    },
  }
</script>

<style lang="scss">
  .app-page-not-found {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);
  }
</style>
