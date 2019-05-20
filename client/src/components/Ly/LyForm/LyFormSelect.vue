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
        @click="changeOption"
      >
        {{ $t('ly.form.select.change') }}
      </ly-button>

      <ly-button
        v-if="!required"
        type="ghost"
        size="small"
        @click="unselectOption"
      >
        {{ $t('ly.form.select.unselect') }}
      </ly-button>

      <ly-icon v-if="icon" :name="icon"></ly-icon>
      {{ selectedOption.label }}
    </div>

    <div v-else class="ly-form-select-input-container">
      <input
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
        @blur="resetOnBlur"
        @keydown.enter.prevent="selectFirstFilteredOption"
      />

      <ly-button
        v-if="!optionsDisplayed"
        icon="caret-down"
        type="ghost"
        size="small"
        @blur="resetOnBlur"
        @click="toggleOptions"
      ></ly-button>
      <ly-button
        v-else
        icon="caret-up"
        type="ghost"
        size="small"
        @blur="resetOnBlur"
        @click="toggleOptions"
      ></ly-button>
    </div>

    <div v-if="!selectedOption && optionsDisplayed" class="ly-form-select-options">
      <a
        v-for="option in filteredOptions"
        class="ly-form-select-option"
        href="#"
        @blur="resetOnBlur"
        @click.prevent="() => selectOption(option)"
      >
        {{ option.label }}
      </a>
      <div v-if="filteredOptions.length === 0" class="ly-form-select-options-placeholder">
        {{ $t('ly.form.select.noOptions') }}
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
      icon: { type: String },
      placeholder: { type: String },
      label: { type: String },
      caption: { type: String },
      error: { type: String },
      required: { type: Boolean },
    },

    data () {
      return {
        filter: '',
        selectedOption: this.getOption(this.value),
        optionsDisplayed: false,
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
    },

    methods: {
      getOption (value) {
        if (!value) {
          return null
        }
        return this.options.find(option => option.value === value)
      },

      focus () {
        const { input } = this.$refs
        input && input.focus()
      },

      resetOnBlur (e) {
        // The role of `resetOnBlur` is to pass in "show" mode (as it was
        // before user clicked on `Choose`) when we lose the focus.
        if (
          e.relatedTarget && (
            e.relatedTarget.parentNode.isSameNode(this.$el) ||
            e.relatedTarget.parentNode.parentNode.isSameNode(this.$el)
          )
        ) {
          // We focus the input, an option or the caret button so we don't want
          // to pass in "selected" mode. This is not a very strong condition so
          // please be careful when you change the DOM.
          return
        }

        this.selectedOption = this.getOption(this.value)
        this.optionsDisplayed = false
      },

      toggleOptions () {
        this.optionsDisplayed = !this.optionsDisplayed
        this.focus()
      },

      selectOption (option) {
        this.filter = ''
        this.selectedOption = option
        this.$emit('input', option.value)
      },

      selectFirstFilteredOption () {
        if (!this.optionsDisplayed) {
          return
        }

        const firstOption = this.filteredOptions[0]
        this.selectOption(firstOption)
      },

      unselectOption () {
        if (!this.required) {
          this.filter = ''
          this.optionsDisplayed = false
          this.selectedOption = null
          this.$emit('input', null)
        }
      },

      changeOption () {
        this.selectedOption = null
        this.filter = ''
        this.optionsDisplayed = true
        this.$nextTick(this.focus)
      },

      onKeypress (e) {
        if (e.key === 'Escape') {
          this.selectedOption = this.getOption(this.value)
          this.optionsDisplayed = false
        }
      },
    },

    watch: {
      value: function (newValue) {
        this.selectedOption = this.getOption(newValue)
      },

      filter: function (newFilter) {
        this.optionsDisplayed = true
      },
    },

    created () {
      window.addEventListener('keydown', this.onKeypress)
    },

    destroyed () {
      window.removeEventListener('keydown', this.onKeypress)
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

  .ly-form-select-input-container {
    position: relative;

    input {
      padding-right: 2.5rem;
    }

    .ly-button {
      position: absolute;
      right: .25rem;
      top: .5rem;
    }
  }

  .ly-form-select-options {
    position: absolute;
    left: 1px;
    right: 1px;
    z-index: 100;

    max-height: 11rem;
    margin-top: -3px;

    overflow-y: auto;

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

    > .ly-form-select-options-placeholder {
      margin-top: -1px;
      padding: .5rem .5rem;

      color: $ly-color-grey-60;

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
