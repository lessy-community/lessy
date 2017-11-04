<template>
  <div class="project-date-indicator">
    <div
      class="indicator-date"
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
  .project-date-indicator {
    position: relative;

    height: 15px;

    background: linear-gradient(90deg, $ly-color-green-50 50%, $ly-color-gold-50, $ly-color-red-50);
    border-radius: .25rem;

    .indicator-date {
      position: absolute;

      height: 0;
      width: 0;
      margin-left: -10px;

      border: 10px solid transparent;
      border-bottom-color: #000;
    }
  }
</style>
