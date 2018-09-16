<template>
  <ly-list stripped>
    <task-selectable-item
      v-for="task in tasks"
      :key="task.id"
      :task="task"
      @select="$emit('select', task)"
    ></task-selectable-item>
  </ly-list>
</template>

<script>
  import TaskSelectableItem from './TaskSelectableItem'

  export default {
    props: {
      tasks: { type: Array },
    },

    components: {
      TaskSelectableItem,
    },
  }
</script>
