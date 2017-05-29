<template>
  <list-item @click="toggleFinishTask" :class="['task-item', { finished: task.isFinished }]">
    <template v-if="task.isFinished">
      <icon name="check-square-o"></icon>
    </template>
    <template v-else>
      <icon name="square-o"></icon>
    </template>
    {{ task.label }}
  </list-item>
</template>

<script>
  export default {

    props: {
      'task': { type: Object, required: true },
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

  .task-item.finished {
    color: #999;
    text-decoration: line-through;
  }

</style>
