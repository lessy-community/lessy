<template>
  <div class="tasks-complete-day">
    <p>
      {{ $t('tasks.completeDay.intro') }}
    </p>

    <p class="text-important">
      {{ summary }}
    </p>

    <task-list
      v-if="this.finishedCount > 0"
      :tasks="finishedTasks"
      nopopover
      nodraggable
      notoggle
    />

    <p>
      {{ $t('tasks.completeDay.addFinishedTasks') }}
    </p>

    <task-create-form :finished-at="finishedAt"></task-create-form>

    <hr />

    <p v-if="this.unfinishedCount > 0" class="text-secondary">
      {{ $t('tasks.completeDay.unfinishedToBacklog') }}
    </p>

    <ly-form-group type="actions">
      <ly-button icon="check" type="primary" size="large" @click="$emit('complete')">
        {{ $t('tasks.completeDay.ok') }}
      </ly-button>
      <ly-button size="large" @click="$emit('cancel')">
        {{ $t('tasks.completeDay.cancel') }}
      </ly-button>
    </ly-form-group>
  </div>
</template>

<script>
  import moment from 'moment'

  import TaskList from '@/components/tasks/TaskList'
  import TaskCreateForm from '@/components/tasks/TaskCreateForm'

  export default {
    props: {
      finishedTasks: { type: Array, required: true },
      unfinishedCount: { type: Number, required: true },
    },

    components: {
      TaskList,
      TaskCreateForm,
    },

    data () {
      return {
        finishedAt: moment(),
      }
    },

    computed: {
      finishedCount () {
        return this.finishedTasks.length
      },

      summary () {
        if (this.unfinishedCount === 0 && this.finishedCount === 0) {
          return this.$t('tasks.completeDay.summary.nothingPlanned')
        }
        if (this.unfinishedCount === 0 && this.finishedCount > 0) {
          return this.$t('tasks.completeDay.summary.allDone')
        }
        if (this.unfinishedCount > 0 && this.finishedCount === 0) {
          return this.$t('tasks.completeDay.summary.nothingDone')
        }
        if (this.unfinishedCount > 0 && this.finishedCount > 0) {
          return this.$tc('tasks.completeDay.summary.neutral', this.finishedCount, {
            finishedCount: this.finishedCount,
            totalCount: this.finishedCount + this.unfinishedCount,
          })
        }
      },
    },
  }
</script>
