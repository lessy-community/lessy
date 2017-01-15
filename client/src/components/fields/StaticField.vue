<template>
  <div class="static-field" :id="id">
    {{ value }}
  </div>
</template>

<script>
  export default {

    name: 'static-field',

    props: {
      id: { type: String },
      value: { type: String, required: true },
    },

  }
</script>
