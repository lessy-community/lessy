<template>
  <div class="loading-page">
    {{ $t('pages.loading.inProgress') }}
  </div>
</template>

<script>
  export default {

    name: 'loading-page',

  }
</script>

<style>

  .container > .loading-page {
    padding-top: 42px;
    font-size: 2rem;
    text-align: center;
  }

</style>
