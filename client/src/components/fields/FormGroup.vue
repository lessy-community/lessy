<template>
  <div :class="['form-group', { 'form-group-actions': actions }]">
    <label v-if="label" :for="target">{{ getLabel }}</label>
    <div :class="['form-group-control', { invalid }]">
      <slot></slot>
      <div v-if="tip" class="form-group-tip">{{ tip }}</div>
    </div>
  </div>
</template>

<script>
  export default {

    name: 'form-group',

    props: {
      'label': { type: String },
      'target': { type: String },
      'tip': { type: String },
      'required': { type: Boolean },
      'invalid': { type: Boolean },
      'actions': { type: Boolean },
    },

    computed: {
      getLabel () {
        return this.label + (this.required ? ' *' : '')
      },
    },

  }
</script>

<style lang="scss">

  .form-group {
    display: flex;
    align-items: flex-start;
  }
  .form-group-actions {
    margin-left: 170px;
  }

  .form-group > label {
    width: 170px;
    padding-top: 8px;
    padding-right: 5px;
    flex-grow: 0;
    flex-shrink: 0;

    color: #555;
  }

  .form-group > .form-group-control {
    flex-grow: 1;
    flex-shrink: 1;
  }

  .form-group-control .form-group-tip {
    padding: 2px 5px;

    color: #555;
    font-size: .9rem;
  }
  .form-group-control.invalid .form-group-tip {
    color: $color-danger;
  }

  .form-group-control {
    margin-bottom: 10px;
  }

  .form-group-control input[type="text"],
  .form-group-control input[type="email"],
  .form-group-control input[type="password"],
  .form-group-control input[type="date"],
  .form-group-control textarea,
  .form-group-control .static-field {
    width: 100%;
    padding: 10px 8px;
    margin-right: 5px;

    color: #555;
    line-height: 1.2rem;
    font-family: inherit;
    font-size: inherit;

    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: 0 1px 1px #eee inset;

    transition: border-color .2s ease-in-out;
  }
  .form-group-control textarea {
    min-height: 150px;
  }
  .form-group-control .static-field {
    border-color: transparent;
    box-shadow: none;
  }
  .form-group-control input[type="text"]:focus,
  .form-group-control input[type="email"]:focus,
  .form-group-control input[type="password"]:focus,
  .form-group-control input[type="date"]:focus,
  .form-group-control textarea:focus {
    border-color: $color-primary;
    background-color: $color-primary-shadow;
  }
  .form-group-control.invalid input[type="text"],
  .form-group-control.invalid input[type="email"],
  .form-group-control.invalid input[type="password"],
  .form-group-control.invalid input[type="date"],
  .form-group-control.invalid textarea,
  .form-group-control input[type="text"]:invalid,
  .form-group-control input[type="email"]:invalid,
  .form-group-control input[type="password"]:invalid,
  .form-group-control input[type="date"]:invalid,
  .form-group-control textarea:invalid {
    border-color: $color-danger;
    background-color: #fbf2f4;
  }

  @media(max-width: $small-screen-width) {
    .form-group {
      flex-direction: column;

      align-items: stretch;

      > label {
        padding-top: 0;
      }
    }

    .form-group-actions {
      margin-left: 0;
    }
  }
</style>
