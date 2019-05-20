<template>
  <button
    :type="submit ? 'submit' : 'button'"
    :class="['ly-button', `ly-button-${type}`, `ly-button-${size}`, { disabled }]"
    @click="onClick"
    @blur="(e) => $emit('blur', e)"
    @mousedown="$emit('on')"
    @mouseup="$emit('off')"
    @mouseout="$emit('off')"
    :disabled="disabled"
  >
    <ly-icon v-if="icon" :name="icon"></ly-icon>
    <slot></slot>
  </button>
</template>

<script>
  import LyIcon from './LyIcon'

  export default {
    props: {
      type: { type: String, default: 'default' },
      size: { type: String, default: 'normal' },
      icon: { type: String },
      submit: { type: Boolean },
      disabled: { type: Boolean },
    },

    components: {
      LyIcon,
    },

    methods: {
      onClick (event) {
        if (!this.submit) {
          event.preventDefault()
        }
        this.$emit('click')
      },
    },
  }
</script>

<style lang="scss">
  .ly-button {
    display: inline-block;
    max-width: 100%;
    margin-right: .25rem;

    vertical-align: middle;

    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;

    color: $ly-color-grey-90;
    line-height: 1.5rem;

    background-color: transparent;
    border: none;
    border-radius: .25rem;

    transition: all .2s ease-in-out;

    > .ly-icon {
      width: auto;
    }
  }

  .ly-button-small {
    padding: 0 .5rem;

    font-size: .8rem;
  }
  .ly-button-normal {
    padding: .25rem 1.5rem;

    font-size: 1rem;
  }
  .ly-button-large {
    padding: .5rem 1.75rem;

    font-size: 1.2rem;
  }

  .ly-button-primary {
    color: $ly-color-white;

    background-color: $ly-color-pine-70;
    box-shadow: 0 0 1px $ly-color-pine-90;

    &.disabled {
      color: $ly-color-grey-20;
      box-shadow: none;
    }

    &:hover:not(.disabled) { background-color: $ly-color-pine-80; }
    &:focus:not(.disabled) { background-color: $ly-color-pine-90; }
  }

  .ly-button-default {
    background-color: $ly-color-grey-20;
    box-shadow: 0 0 1px $ly-color-grey-90;

    &.disabled {
      color: $ly-color-grey-60;
      box-shadow: 0 0 1px $ly-color-grey-60;
    }

    &:hover:not(.disabled) { background-color: $ly-color-grey-30; }
    &:focus:not(.disabled) { background-color: $ly-color-grey-40; }
  }

  .ly-button-ghost {
    padding-left: .5rem;
    padding-right: .5rem;

    background-color: transparentize($ly-color-grey-90, .9);

    &.disabled {
      color: $ly-color-grey-60;
    }

    &:hover:not(.disabled) { background-color: transparentize($ly-color-grey-90, .8); }
    &:focus:not(.disabled) { background-color: transparentize($ly-color-grey-90, .7); }
  }
</style>
