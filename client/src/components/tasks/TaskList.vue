<template>
  <ly-list
    :placeholder="$t('tasks.list.empty')"
    stripped
    :draggable="!nodraggable"
    :draggable-model="tasks"
    @draggable-change="changeOrder"
  >
    <task-item
      v-for="task in tasks"
      :key="task.id"
      :task="task"
      :nopopover="nopopover"
      :notoggle="notoggle"
      :nohandle="nodraggable"
      :hide-project-badge="hideProjectBadge"
    ></task-item>
  </ly-list>
</template>

<script>
  import TaskItem from './TaskItem'

  export default {
    props: {
      'tasks': { type: Array },
      'nopopover': { type: Boolean },
      'nodraggable': { type: Boolean },
      'notoggle': { type: Boolean },
      'hideProjectBadge': { type: Boolean },
    },

    components: {
      TaskItem,
    },

    methods: {
      changeOrder (event) {
        if (this.nodraggable) {
          return
        }
        const { moved: { oldIndex, newIndex } } = event
        const task = this.tasks[oldIndex]
        const order = this.tasks[newIndex].order
        this.$store.dispatch('tasks/updateOrder', { task, order })
      },
    },
  }
</script>
