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

<style>

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
    background-color: #0080b0;
  }
  .btn.primary:hover {
    background-color: #006389;
  }
  .btn.primary:focus {
    box-shadow: 0 0 0 2px #09b8fb;
  }

  .btn.secondary {
    color: #0080b0;
    border-color: #0080b0;
  }
  .btn.secondary:hover {
    background-color: #e2f4fb;
  }
  .btn.secondary:focus {
    box-shadow: 0 0 0 2px #09b8fb;
  }

  .btn.cancel {
    color: #ff2c00;
  }
  .btn.cancel:hover {
    border-color: #ff2c00;
  }
  .btn.cancel:focus {
    box-shadow: 0 0 0 2px #ff7f64;
  }

</style>
