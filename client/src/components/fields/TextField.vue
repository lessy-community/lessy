<template>
  <textarea
    v-if="multiplelines"
    :value="value"
    :id="id"
    :required="required"
    @input="$emit('input', $event.target.value)"
  ></textarea>
  <input
    v-else
    type="text"
    :value="value"
    :id="id"
    :required="required"
    :pattern="pattern"
    @input="$emit('input', $event.target.value)"
  />
</template>

<script>
  export default {

    name: 'text-field',

    props: {
      id: { type: String },
      value: { type: String, required: true },
      required: { type: Boolean },
      pattern: { type: String },
      multiplelines: { type: Boolean },
    },

  }
</script>
