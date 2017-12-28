<template>
  <transition name="ly-modal">
    <div class="ly-modal-mask">
      <section class="ly-modal-container">
        <header v-if="title" class="ly-modal-header">
          {{ title }}
        </header>

        <div class="ly-modal-body">
          <slot></slot>
        </div>
      </section>
    </div>
  </transition>
</template>

<script>
  export default {
    props: {
      title: { type: String },
    },

    beforeCreate () {
      document.body.classList.add('modal-opened')
    },

    destroyed () {
      document.body.classList.remove('modal-opened')
    },
  }
</script>

<style lang="scss">
  .ly-modal-mask {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 999;

    overflow-x: hidden;
    overflow-y: auto;

    background-color: rgba($ly-color-grey-90, .5);
    transition: opacity .2s ease-in-out;
  }

  .ly-modal-container {
    max-width: 30rem;
    margin: 5rem auto;

    background-color: $ly-color-grey-10;
    border-radius: .25rem;
    box-shadow: 0 0 1px $ly-color-grey-50,
                1px 2px 3px $ly-color-grey-60;
    transition: all .2s ease-in-out;
  }

  .ly-modal-header {
    padding: .5rem 1rem 0;

    font-size: 1.1rem;
    font-weight: bold;
  }
  .ly-modal-body {
    padding: 1rem;
  }

  .ly-modal-enter {
    opacity: 0;
  }

  .ly-modal-leave-active {
    opacity: 0;
  }

  .ly-modal-enter .ly-modal-container,
  .ly-modal-leave-active .ly-modal-container {
    transform: scale(1.1);
  }

  @media(max-width: $small-screen-width) {
    .ly-modal-container {
      max-width: none;
      margin-top: 3rem;
      margin-left: 1rem;
      margin-right: 1rem;
    }
  }
</style>
