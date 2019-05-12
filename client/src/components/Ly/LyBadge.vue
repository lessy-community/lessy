<template>
  <div :class="['ly-badge', `ly-badge-${typeClass}`, `ly-badge-${size}`, { [`ly-badge-${name}`]: name }]">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: {
      type: { type: [String, Object], default: 'default' },
      name: { type: String },
      size: { type: String, default: 'normal' },
    },

    computed: {
      typeClass () {
        if (typeof this.type === 'string') {
          return this.type
        }
        const firstEnabledType = Object.entries(this.type).find(elt => elt[1])
        return firstEnabledType ? firstEnabledType[0] : 'default'
      },
    },
  }
</script>

<style lang="scss">
  .ly-badge {
    display: inline-block;
    margin-left: .25rem;
    margin-right: .25rem;

    white-space: nowrap;
    word-wrap: break-word;

    border-radius: .25rem;

    .ly-icon {
      width: auto;
    }

    &.ly-badge-default {
      color: $ly-color-grey-60;
      box-shadow: 0 0 1px $ly-color-grey-80;
      background-color: $ly-color-grey-10;
    }
    &.ly-badge-primary {
      color: $ly-color-grey-90;
      background-color: $ly-color-pine-50;
    }
    &.ly-badge-success {
      color: $ly-color-grey-90;
      background-color: $ly-color-green-50;
    }
    &.ly-badge-warning {
      color: $ly-color-grey-90;
      background-color: $ly-color-gold-50;
    }
    &.ly-badge-alert {
      color: $ly-color-white;
      background-color: $ly-color-red-50;
    }

    &.ly-badge-small {
      padding-left: .25rem;
      padding-right: .25rem;

      font-size: .9em;
    }
    &.ly-badge-normal {
      padding: .25rem .5rem;

      font-size: 1em;
    }
    &.ly-badge-large {
      padding: .5rem .75rem;

      font-size: 1.1em;
    }
  }

  @media(max-width: $small-screen-width) {
    .ly-badge {
      display: block;
      margin: .25rem 0;

      white-space: normal;
    }
  }
</style>
