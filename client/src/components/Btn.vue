<template>
  <button
    :type="submit ? 'submit' : 'button'"
    :class="['btn', type]"
    :title="tip"
    @click="onClick"
    @mousedown="$emit('on')"
    @mouseup="$emit('off')"
    @mouseout="$emit('off')"
  >
    <slot></slot>
  </button>
</template>

<script>
  export default {

    name: 'btn',

    props: {
      'type': { type: String, default: 'primary' },
      'submit': { type: Boolean },
      'tip': { type: String },
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

  .btn {
    display: inline-block;
    max-width: 100%;
    margin-right: 4px;
    padding: 8px 10px;
    vertical-align: middle;

    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;

    font-size: 1rem;
    line-height: 1.4rem;

    background: none;
    border: 1px solid transparent;
    border-radius: 4px;

    transition: all .2s ease-in-out;
  }
  .btn:focus {
    outline: none;
  }
  .btn::-moz-focus-inner {
    border: 0;
  }

  .btn.primary {
    color: #fff;
    background-color: $color-primary;
  }
  .btn.primary:hover {
    background-color: $color-primary-dark;
  }
  .btn.primary:focus {
    box-shadow: 0 0 0 2px $color-primary-lighter;
  }

  .btn.secondary {
    color: $color-primary;
    border-color: $color-primary;
  }
  .btn.secondary:hover {
    background-color: $color-primary-shadow;
  }
  .btn.secondary:focus {
    box-shadow: 0 0 0 2px $color-primary-lighter;
  }

  .btn.danger {
    color: #fff;
    background-color: $color-danger;
  }
  .btn.danger:hover {
    background-color: $color-danger-dark;
  }
  .btn.danger:focus {
    box-shadow: 0 0 0 2px $color-danger-lighter;
  }

  .btn.cancel {
    color: $color-danger;
  }
  .btn.cancel:hover {
    border-color: $color-danger;
  }
  .btn.cancel:focus {
    box-shadow: 0 0 0 2px $color-danger-lighter;
  }

</style>
