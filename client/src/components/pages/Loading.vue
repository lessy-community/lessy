<template>
  <app-content contentClass="loading-page">
    <div>
      <icon name="spinner" pulse size="2"></icon>
    </div>
    <div>{{ $t('pages.loading.inProgress') }}</div>
  </app-content>
</template>

<script>
  export default {

    name: 'loading-page',

  }
</script>

<style>

  .app-body.loading-page {
    display: flex;
    justify-content: center;
    align-items: center;

    font-size: 2rem;
  }

</style>
