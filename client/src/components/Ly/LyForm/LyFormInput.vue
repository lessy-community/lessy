<template>
  <div :class="['ly-form-input', `ly-form-input-${type}`]">
    <label v-if="label" :for="name">
      {{ label }}
      <span v-if="!required" class="text-secondary">
        ({{ $t('ly.form.input.optional') }})
      </span>
    </label>

    <p v-if="caption" class="ly-form-input-caption">{{ caption }}</p>

    <div class="ly-form-input-group">
      <input
        ref="input"
        :id="name"
        :class="[{ invalid }]"
        :name="name"
        :type="inputType"
        :value="inputValue"
        :placeholder="placeholder"
        :pattern="pattern"
        :required="required"
        :invalid="invalid"
        :autocomplete="autocomplete"
        :disabled="disabled"
        @input="$emit('input', $event.target.value)"
      />

      <ly-button
        v-if="type == 'password'"
        type="ghost"
        icon="eye"
        @on="showPassword = true"
        @off="showPassword = false"
        :disabled="disabled"
      >
        <span class="no-mobile">{{ $t('ly.form.input.revealPassword') }}</span>
      </ly-button>
    </div>

    <p v-if="invalid" class="ly-form-input-error">{{ error }}</p>
  </div>
</template>

<script>
  import moment from 'moment'

  export default {
    props: {
      value: { type: [String, Number, Date], required: true },
      type: { type: String, required: true },
      name: { type: String, required: true },
      placeholder: { type: String },
      pattern: { type: String },
      label: { type: String },
      caption: { type: String },
      error: { type: String },
      autocomplete: { type: String },
      required: { type: Boolean },
      disabled: { type: Boolean },
    },

    data () {
      return {
        showPassword: false,
      }
    },

    computed: {
      invalid () {
        return !!this.error
      },

      inputType () {
        if (this.type === 'password') {
          return this.showPassword ? 'text' : 'password'
        }
        return this.type
      },

      inputValue () {
        if (this.type === 'date' && this.value instanceof Date) {
          // TODO: beurk
          return moment(this.value).format('YYYY-MM-DD')
        }
        return this.value
      },
    },

    methods: {
      focus () {
        const { input } = this.$refs
        input && input.focus()
      },
    },
  }
</script>

<style lang="scss">
  .ly-form-input-group {
    display: flex;

    > .ly-button {
      margin-left: .25rem;
      margin-right: 0;

      flex-shrink: 0;
    }
  }

  .ly-form-input-caption {
    margin-top: -.5rem;
    margin-bottom: .25rem;
    padding-left: .5rem;

    color: $ly-color-grey-50;
    font-size: .8rem;
  }

  .ly-form-input-error {
    margin-bottom: 0;
    padding-left: .5rem;

    color: $ly-color-red-50;
  }
</style>
