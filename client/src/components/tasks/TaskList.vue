<template>
  <div class="list task-list">
    <task-item
      v-for="task in tasks"
      :key="task.id"
      :task="task"
      :notoggle="notoggle"
    ></task-item>
  </div>
</template>

<script>
  import TaskItem from '../tasks/TaskItem'

  export default {
    props: {
      'tasks': { type: Array },
      'notoggle': { type: Boolean },
    },

    components: {
      TaskItem,
    },
  }
</script>

<style lang="scss">
  .task-list {
    margin-bottom: 10px;
  }
</style>
