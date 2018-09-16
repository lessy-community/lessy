<template>
  <div class="tasks-planner">
    <div v-if="tasks.length === 0" class="tasks-planner-placeholder">
      <p class="text-secondary">
        {{ $t('tasks.planner.empty') }}
      </p>

      <ly-button
        type="primary"
        icon="rocket"
        size="large"
        @click="showTaskPlanModal = true"
      >
        {{ $t('tasks.planner.planTask') }}
      </ly-button>
    </div>
    <ly-section v-else :title="$tc('tasks.planner.tasksForToday', tasks.length, { count: tasks.length })">
      <ly-list stripped>
        <task-item
          v-for="task in tasks"
          :key="task.id"
          :task="task"
          nohandle
        ></task-item>

        <ly-list-item
          v-for="i in nbPlaceholders"
          class="text-secondary"
        >
          {{ $tc(`tasks.planner.importantTaskPlaceholder.${i - 1}`, tasks.length) }}
        </ly-list-item>
      </ly-list>

      <ly-button
        :type="planButtonType"
        icon="calendar-plus-o"
        @click="showTaskPlanModal = true"
      >
        {{ $t('tasks.planner.planTask') }}
      </ly-button>
    </ly-section>

    <task-plan-modal
      v-if="showTaskPlanModal"
      :intro="planModalIntro"
      @close="showTaskPlanModal = false"
    >
    </task-plan-modal>
  </div>
</template>

<script>
  import TaskItem from './TaskItem'
  import TaskPlanModal from './TaskPlanModal'

  export default {
    props: {
      tasks: { type: Array },
    },

    components: {
      TaskItem,
      TaskPlanModal,
    },

    data () {
      return {
        showTaskPlanModal: false,
      }
    },

    computed: {
      nbPlaceholders () {
        return Math.max(3 - this.tasks.length, 0)
      },

      planButtonType () {
        return [0, 1, 2].includes(this.tasks.length) ? 'primary' : 'default'
      },

      planModalIntro () {
        switch (this.tasks.length) {
          case 0:
            return this.$t('tasks.planner.firstMostImportantTask')
          case 1:
          case 2:
            return this.$t('tasks.planner.additionalMostImportantTask')
          default:
            return this.$t('tasks.planner.additionalTask')
        }
      },
    },
  }
</script>

<style lang="scss">
  .tasks-planner-placeholder {
    text-align: center;
  }
</style>
