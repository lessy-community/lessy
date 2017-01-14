<template>
  <div class="error-page">
    {{ message }}
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
