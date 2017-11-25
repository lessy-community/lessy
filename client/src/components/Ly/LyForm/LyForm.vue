<template>
  <form
    :class="['ly-form', `ly-form-${size}`, { margined }]"
    @submit.prevent="$emit('submit')"
  >
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
      size: { type: String, default: 'normal' },
      margined: { type: Boolean },
      error: { type: String },
    },
  }
</script>

<style lang="scss">
  .ly-form {
    &.ly-form-small {
      max-width: 20rem;
    }
    &.ly-form-normal {
      max-width: 30rem;
    }
    &.ly-form-large {
      max-width: 40rem;
    }
    &.ly-form-fluid {
      max-width: none;
    }

    &.margined {
      margin-left: auto;
      margin-right: auto;
    }
  }

  .ly-form-error {
    padding-left: .5rem;

    color: $ly-color-red-50;
  }
</style>
