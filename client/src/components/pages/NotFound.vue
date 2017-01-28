<template>
  <div class="not-found-page">
    <h1>{{ $t('pages.notFound.title') }}</h1>
    <p>{{ $t('pages.notFound.intro') }}</p>
    <div>
      <router-link to="/">{{ $t('pages.notFound.home') }}</router-link>
    </div>
  </div>
</template>

<script>
  export default {

    name: 'not-found-page',

  }
</script>

<style>

  .container > .not-found-page {
    padding-top: 42px;
    font-size: 2rem;
    text-align: center;
  }

</style>
