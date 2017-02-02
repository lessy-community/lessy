<template>
  <app-content contentClass="loading-page">
    {{ $t('pages.loading.inProgress') }}
  </app-content>
</template>

<script>
  export default {

    name: 'loading-page',

  }
</script>

<style>

  .loading-page {
    padding-top: 42px;
    font-size: 2rem;
    text-align: center;
  }

</style>
