<template>
  <input
    type="email"
    :value="value"
    :id="id"
    :required="required"
    @input="$emit('input', $event.target.value)"
  />
</template>

<script>
  export default {

    name: 'email-field',

    props: {
      id: { type: String },
      value: { type: String, required: true },
      required: { type: Boolean },
    },

  }
</script>
