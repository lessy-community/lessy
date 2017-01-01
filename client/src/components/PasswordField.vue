<template>
  <div class="password-field">
    <input
      :value="value"
      :type="type"
      :id="id"
      :required="required"
      @input="$emit('input', $event.target.value)"
    />
    <a
      href="#"
      title="Show password in plain text"
      @mousedown.prevent="showPassword = true"
      @mouseup.prevent="showPassword = false"
      @mouseout.prevent="showPassword = false"
      @click.prevent
    >&#128065;</a>
  </div>
</template>

<script>
export default {
  name: 'password-default',
  props: {
    value: { type: String, required: true },
    id: { type: String },
    required: { type: Boolean },
  },
  data () {
    return {
      showPassword: false,
    }
  },
  computed: {
    type () {
      return this.showPassword ? 'text' : 'password'
    },
  },
}
</script>

<style scoped>
.password-field {
  display: inline;
}
</style>
