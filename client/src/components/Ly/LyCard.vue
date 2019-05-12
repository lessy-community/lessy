<template>
  <section :class="['ly-card', `ly-card-${type}`, {
    [`ly-card-${name}`]: name,
  }]">
    <header v-if="$slots.header" class="ly-card-header">
      <slot name="header"></slot>
    </header>
    <div class="ly-card-body" :style="style">
      <slot></slot>
    </div>
    <footer v-if="$slots.footer" class="ly-card-footer">
      <slot name="footer"></slot>
    </footer>
  </section>
</template>

<script>
  export default {
    props: {
      type: { type: String, default: 'normal' },
      name: { type: String },
      image: { type: String },
    },

    computed: {
      style () {
        if (!this.image) {
          return {}
        }
        return {
          backgroundImage: `url(${this.image})`,
        }
      },
    },
  }
</script>

<style lang="scss">
  .ly-card {
    display: flex;
    min-width: 0;
    margin-bottom: 1rem;

    flex-direction: column;

    word-wrap: break-word;

    background-color: $ly-color-grey-10;
    box-shadow: 0 0 1px $ly-color-grey-50,
                1px 2px 3px $ly-color-grey-40;
    border-radius: .25rem;

    &.ly-card-placeholder {
      justify-content: center;

      background-color: $ly-color-grey-20;
    }
  }

  .ly-card-header {
    padding: .5rem 1rem 0;

    font-size: 1.1rem;
    font-weight: bold;
  }

  .ly-card-body {
    padding: 1rem;

    flex: 1 1 auto;

    border-radius: .25rem;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
  }
  .ly-card-placeholder .ly-card-body {
    flex-grow: 0;

    color: $ly-color-grey-60;
    font-size: 1.1rem;
    text-align: center;
  }

  .ly-card-footer {
    padding: .5rem 1rem;

    background-color: $ly-color-grey-20;
    box-shadow: 0 -1px 0 $ly-color-grey-30;
    border-radius: 0 0 .25rem .25rem;
  }
</style>
