<template>
  <div class="password-field">
    <input
      :value="value"
      :type="type"
      :id="id"
      :required="required"
      @input="$emit('input', $event.target.value)"
    />
    <btn
      type="secondary"
      :tip="$t('fields.password.tip')"
      @on="showPassword = true"
      @off="showPassword = false"
    >
      <icon name="eye"></icon>
    </btn>
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
    display: flex;
  }

</style>
