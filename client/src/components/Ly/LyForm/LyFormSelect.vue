<template>
  <div class="ly-form-select">
    <label v-if="label" :for="name">
      {{ label }}
      <span v-if="!required" class="text-secondary">
        ({{ $t('ly.form.input.optional') }})
      </span>
    </label>

    <p v-if="caption" class="ly-form-select-caption">{{ caption }}</p>

    <div v-if="selectedOption" class="ly-form-select-option-selected">
      <ly-button
        type="ghost"
        size="small"
        @click="unselectOption"
      >
        {{ $t('ly.form.select.unselect') }}
      </ly-button>

      {{ selectedOption.label }}
    </div>
    <input
      v-else
      ref="input"
      type="text"
      :id="name"
      :class="[{ invalid }]"
      :name="name"
      v-model="filter"
      :placeholder="placeholder"
      :required="required"
      :invalid="invalid"
      autocomplete="off"
      @keydown.enter.prevent="selectFirstFilteredOption"
    />

    <div v-if="filter && !value" class="ly-form-select-options">
      <a
        v-for="option in limitedFilteredOptions"
        class="ly-form-select-option"
        href="#"
        @click.prevent="() => selectOption(option)"
      >
        {{ option.label }}
      </a>
      <div v-if="numberMoreOptions > 0" class="ly-form-select-options-more">
        {{ $tc('ly.form.select.moreOptions', numberMoreOptions, { number: numberMoreOptions }) }}
      </div>
    </div>

    <p v-if="invalid" class="ly-form-select-error">{{ error }}</p>
  </div>
</template>

<script>
  export default {
    props: {
      options: { type: Array, required: true },
      name: { type: String, required: true },
      value: { type: [Number, String] },
      placeholder: { type: String },
      label: { type: String },
      caption: { type: String },
      error: { type: String },
      required: { type: Boolean },
    },

    data () {
      return {
        filter: '',
      }
    },

    computed: {
      invalid () {
        return !!this.error
      },

      filteredOptions () {
        const filterRegex = new RegExp(this.filter, 'i')
        return this.options.filter(option => filterRegex.test(option.label))
      },

      limitedFilteredOptions () {
        return this.filteredOptions.slice(0, 5)
      },

      numberMoreOptions () {
        return this.filteredOptions.length - 5
      },

      selectedOption () {
        if (!this.value) {
          return null
        }
        return this.options.find(option => option.value === this.value)
      },
    },

    methods: {
      focus () {
        const { input } = this.$refs
        input && input.focus()
      },

      selectOption (option) {
        this.$emit('input', option.value)
      },

      selectFirstFilteredOption () {
        if (!this.filter) {
          return
        }

        const firstOption = this.filteredOptions[0]
        this.selectOption(firstOption)
      },

      unselectOption () {
        this.filter = ''
        this.$emit('input', null)
        this.$nextTick(this.focus)
      },
    },
  }
</script>

<style lang="scss">
  .ly-form-select {
    position: relative;
  }

  .ly-form-select-option-selected {
    display: block;
    padding: .5rem;

    background-color: $ly-color-grey-20;
    border-radius: .25rem;

    > .ly-button {
      float: right;

      margin-left: .25rem;
      margin-right: 0;
    }

    &::after {
      content: "";
      display: table;
      clear: both;
    }
  }

  .ly-form-select-options {
    position: absolute;
    left: 1px;
    right: 1px;
    z-index: 100;

    margin-top: -3px;

    background-color: $ly-color-grey-10;
    box-shadow: 0 0 1px $ly-color-grey-50,
                1px 2px 3px $ly-color-grey-60;
    border-radius: 0 0 .25rem .25rem;

    > .ly-form-select-option {
      display: block;
      padding: .5rem .5rem;

      text-decoration: none;
    }
    > .ly-form-select-option + .ly-form-select-option {
      margin-top: -1px;

      border-top: 1px solid $ly-color-grey-30;
    }
    > .ly-form-select-option:last-child {
      border-radius: 0 0 .25rem .25rem;
    }
    > .ly-form-select-option:hover {
      background-color: $ly-color-grey-20;
    }

    > .ly-form-select-options-more {
      margin-top: -1px;
      padding: .5rem .5rem;

      color: $ly-color-grey-60;

      border-top: 1px solid $ly-color-grey-30;
      background-color: $ly-color-grey-20;
      border-radius: 0 0 .25rem .25rem;
    }
  }

  .ly-form-select-caption {
    margin-top: -.5rem;
    margin-bottom: .25rem;
    padding-left: .5rem;

    color: $ly-color-grey-60;
    font-size: .8rem;
  }

  .ly-form-select-error {
    margin-bottom: 0;
    padding-left: .5rem;

    color: $ly-color-red-50;
  }
</style>
