<template>
  <div class="list task-list">
    <div v-if="sortableTasks.length === 0" class="list-placeholder">
      {{ $t('tasks.emptyList') }}
    </div>
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
          :hide-project-badge="hideProjectBadge"
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
      'hideProjectBadge': { type: Boolean },
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

  .list-placeholder {
    padding: 10px 15px;

    color: #777;
    font-style: italic;
  }
</style>
