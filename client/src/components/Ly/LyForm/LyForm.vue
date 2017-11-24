<template>
  <form class="ly-form" @submit.prevent="$emit('submit')">
    <p v-if="error" class="ly-form-error">
      <ly-icon name="exclamation-circle"></ly-icon>
      {{ error }}
    </p>
    <slot></slot>
  </form>
</template>

<script>
  export default {
    props: {
      error: { type: String },
    },
  }
</script>

<style lang="scss">
  .ly-form-error {
    padding-left: .5rem;

    color: $ly-color-red-50;
  }
</style>
