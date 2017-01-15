<template>
  <div class="error-page">
    <h1>Oops…</h1>
    <p>{{ message }}</p>
    <div>
      <router-link to="/">Go home</router-link>
    </div>
  </div>
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

  .container > .error-page {
    padding-top: 42px;
    font-size: 2rem;
    text-align: center;
  }

</style>
