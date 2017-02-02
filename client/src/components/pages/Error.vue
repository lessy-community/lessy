<template>
  <app-content contentClass="error-page">
    <h1>{{ $t('pages.error.title') }}</h1>
    <p>{{ message }}</p>
    <div>
      <router-link to="/">Go home</router-link>
    </div>
  </app-content>
</template>

<script>
  export default {

    name: 'error-page',

    props: {
      'message': { type: String, required: true },
    },

  }
</script>

<style>

  .error-page {
    padding-top: 42px;
    font-size: 2rem;
    text-align: center;
  }

</style>
