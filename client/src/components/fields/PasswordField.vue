<template>
  <div class="password-field">
    <input
      :value="value"
      :type="type"
      :id="id"
      :required="required"
      @input="$emit('input', $event.target.value)"
    />
    <ly-button
      type="ghost"
      icon="eye"
      @on="showPassword = true"
      @off="showPassword = false"
    >
      <span class="no-mobile">{{ $t('fields.password.reveal') }}</span>
    </ly-button>
  </div>
</template>

<script>
  export default {
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

<style scoped lang="scss">
  .password-field {
    display: flex;

    > .ly-button {
      flex-shrink: 0;
    }
  }
</style>
