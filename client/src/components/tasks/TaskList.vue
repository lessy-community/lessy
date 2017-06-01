<template>
  <div class="list task-list">
    <draggable
      v-model="sortableTasks"
      @change="changeOrder"
      :options="{ handle: '.my-handle' }"
    >
      <transition-group>
        <task-item
          v-for="task in sortableTasks"
          :key="task.id"
          :task="task"
          :notoggle="notoggle"
        ></task-item>
      </transition-group>
    </draggable>
  </div>
</template>

<script>
  import draggable from 'vuedraggable'

  import TaskItem from '../tasks/TaskItem'

  export default {
    props: {
      'tasks': { type: Array },
      'notoggle': { type: Boolean },
    },

    components: {
      TaskItem,
      draggable,
    },

    computed: {
      sortableTasks: {
        get () {
          return this.tasks
        },
      },
    },

    methods: {
      changeOrder (event) {
        const { moved: { oldIndex, newIndex } } = event
        const task = this.tasks[oldIndex]
        const afterTaskIndex = newIndex > oldIndex ? newIndex : newIndex - 1
        const afterTask = this.tasks[afterTaskIndex]
        const afterTaskId = afterTask == null ? null : afterTask.id
        this.$store.dispatch('tasks/orderAfter', { task, afterTaskId })
      },
    },
  }
</script>

<style lang="scss">
  .task-list {
    margin-bottom: 10px;
  }
</style>
