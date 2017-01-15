<template>
  <div class="not-found-page">
    <h1>Page not found</h1>
    <p>It looks like this page doesn't exist…</p>
    <div>
      <router-link to="/">Home page</router-link>
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
