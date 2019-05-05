<template>
  <div class="tasks-planner">
    <div v-if="tasksTotalCount === 0" class="tasks-planner-placeholder">
      <p class="text-secondary">
        {{ $t('tasks.planner.empty') }}
      </p>

      <ly-button
        type="primary"
        icon="rocket"
        size="large"
        @click="activeModal = 'plan'"
      >
        {{ $t('tasks.planner.startJourney') }}
      </ly-button>
    </div>
    <template v-else>
      <ly-section :title="$tc('tasks.planner.tasksForToday', this.todoTasks.length, { count: this.todoTasks.length })">
        <ly-list stripped :placeholder="$t('tasks.planner.allFinished')">
          <task-item
            v-for="task in todoTasks"
            :key="task.id"
            :task="task"
            nohandle
          ></task-item>

          <ly-list-item
            v-for="i in nbPlaceholders"
            :key="i"
            class="text-secondary"
          >
            {{ $tc(`tasks.planner.importantTaskPlaceholder.${i - 1}`, tasksTotalCount) }}
          </ly-list-item>
        </ly-list>

        <ly-button
          v-if="showEndOfDayButton"
          type="primary"
          icon="check"
          @click="activeModal = 'finishDay'"
        >
          {{ $t('tasks.planner.finishDay') }}
        </ly-button>

        <ly-button
          :type="planButtonType"
          icon="calendar-plus-o"
          @click="activeModal = 'plan'"
        >
          {{ $t('tasks.planner.planTask') }}
        </ly-button>
      </ly-section>

      <ly-section v-if="finishedTasks.length > 0" :title="$tc('tasks.planner.tasksFinishedToday', this.finishedTasks.length, { count: this.finishedTasks.length })">
        <ly-list stripped>
          <task-item
            v-for="task in finishedTasks"
            :key="task.id"
            :task="task"
            nohandle
          ></task-item>
        </ly-list>
      </ly-section>
    </template>

    <tasks-plan-modal
      v-if="activeModal === 'plan'"
      :intro="planModalIntro"
      @close="activeModal = null"
    >
    </tasks-plan-modal>

    <tasks-complete-day-modal
      v-if="activeModal === 'finishDay'"
      :unfinishedCount="todoTasks.length"
      :finishedCount="finishedTasks.length"
      @complete="completeDay"
      @close="activeModal = null"
    >
    </tasks-complete-day-modal>
  </div>
</template>

<script>
  import TaskItem from './TaskItem'
  import TasksPlanModal from './TasksPlanModal'
  import TasksCompleteDayModal from './TasksCompleteDayModal'

  export default {
    props: {
      todoTasks: { type: Array },
      finishedTasks: { type: Array },
      showEndOfDayButton: { type: Boolean },
    },

    components: {
      TaskItem,
      TasksPlanModal,
      TasksCompleteDayModal,
    },

    data () {
      return {
        activeModal: null,
      }
    },

    computed: {
      tasksTotalCount () {
        return this.todoTasks.length + this.finishedTasks.length
      },

      nbPlaceholders () {
        return Math.max(3 - this.tasksTotalCount, 0)
      },

      planButtonType () {
        if (this.showEndOfDayButton) {
          return 'ghost'
        }
        return [0, 1, 2].includes(this.tasksTotalCount) ? 'primary' : 'default'
      },

      planModalIntro () {
        switch (this.tasksTotalCount) {
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

    methods: {
      completeDay () {
        this.$emit('completed')
        this.activeModal = null
      },
    },
  }
</script>

<style lang="scss">
  .tasks-planner-placeholder {
    text-align: center;
  }
</style>
