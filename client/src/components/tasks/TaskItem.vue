<template>
  <list-item :class="['task-item', { finished: task.isFinished }]">
    <a v-if="!disableToggle" href="#" @click.prevent="toggleFinishTask" class="toggle">
      <icon v-if="task.isFinished" name="check-square-o"></icon>
      <icon v-else name="square-o"></icon>
    </a>
    <span class="label">{{ task.label }}</span>
  </list-item>
</template>

<script>
  export default {

    props: {
      'task': { type: Object, required: true },
      'disable-toggle': { type: Boolean },
    },

    methods: {
      toggleFinishTask () {
        const { task } = this
        if (task.isFinished) {
          this.$store.dispatch('tasks/restart', { task })
        } else {
          this.$store.dispatch('tasks/finish', { task })
        }
      },
    },

  }
</script>

<style lang="scss">

  .task-item {
    .toggle {
      padding: 5px;
    }

    &:nth-child(even) {
      background-color: #f4f4f4;
    }

    &.finished .label {
      color: #999;
      text-decoration: line-through;
    }
    &.finished .toggle {
      color: #999;
    }
  }

</style>
