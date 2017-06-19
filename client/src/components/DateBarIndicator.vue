<template>
  <div class="date-bar-indicator">
    <div
      class="date-bar-indicator-date"
      :style="{ left }"
    ></div>
  </div>
</template>

<script>
  export default {
    props: {
      start: { type: Number, required: true },
      end: { type: Number, required: true },
      date: { type: Number, required: true },
    },

    computed: {
      left () {
        const percent = Math.min(100, Math.max(0, (this.date - this.start) / (this.end - this.start) * 100))
        return `${percent}%`
      },
    },
  }
</script>

<style lang="scss">
  .date-bar-indicator {
    position: relative;

    height: 15px;

    background: linear-gradient(90deg, $color-success-light 50%, $color-warning-light, $color-danger-light);
  }

  .date-bar-indicator-date {
    position: absolute;

    height: 0;
    width: 0;
    margin-left: -10px;

    border: 10px solid transparent;
    border-bottom-color: #000;
  }
</style>
