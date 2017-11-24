<template>
  <div class="ly-form-input ly-form-input-textarea">
    <label v-if="label" :for="name">
      {{ label }}
      <span v-if="!required" class="text-secondary">
        ({{ $t('ly.form.input.optional') }})
      </span>
    </label>

    <p v-if="caption" class="ly-form-input-caption">{{ caption }}</p>

    <textarea
      ref="textarea"
      :id="name"
      :name="name"
      :value="value"
      :required="required"
      :invalid="invalid"
      :class="[{ invalid }]"
      @input="$emit('input', $event.target.value)"
    ></textarea>

    <p v-if="invalid" class="ly-form-input-error">{{ error }}</p>
  </div>
</template>

<script>
  import autosize from 'autosize'

  export default {
    props: {
      value: { type: String, required: true },
      name: { type: String, required: true },
      label: { type: String },
      caption: { type: String },
      error: { type: String },
      required: { type: Boolean },
    },

    computed: {
      invalid () {
        return !!this.error
      },
    },

    mounted () {
      autosize(this.$refs.textarea)
    },

    beforeDestroy () {
      autosize.destroy(this.$refs.textarea)
    },
  }
</script>
