<template>
  <app-content contentClass="loading-page">
    <div class="loading-page-message">{{ $t('pages.loading.inProgress') }}</div>
    <icon name="spinner" pulse size="2"></icon>
  </app-content>
</template>

<script>
  export default {

    name: 'loading-page',

  }
</script>

<style lang="scss">

  .app-body.loading-page {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    font-size: 2rem;

    .loading-page-message {
      margin-bottom: 30px;

      text-align: center;
    }
  }

</style>
