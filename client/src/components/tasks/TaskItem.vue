<template>
  <task-edit-form
    v-if="editMode"
    autoFocus
    :task="task"
    :onSuccess="() => { this.editMode = false }"
    :onCancel="() => { this.editMode = false }"
  ></task-edit-form>
  <ly-list-item v-else name="task" with-handle :class="[{ finished: task.isFinished }]">
    <ly-list-item-adapt>
      <span v-html="task.formattedLabel"></span>
      <ly-badge v-if="task.projectName && !hideProjectBadge" size="small">
        <router-link :to="task.urlProjectShow">
          {{ task.projectName }}
        </router-link>
      </ly-badge>
    </ly-list-item-adapt>

    <ly-badge
      name="indicators"
      v-if="task.createdSinceWeeks > 0 || task.restartedCount > 0"
      :type="{ alert: task.createdSinceWeeks > 2 || task.restartedCount > 2, warning: task.createdSinceWeeks === 2 || task.restartedCount === 2 }"
    >
      <span
        v-if="task.createdSinceWeeks > 0"
        v-tooltip.left="$tc('tasks.item.createdSinceWeeks', task.createdSinceWeeks, { count: task.createdSinceWeeks })"
      >
        <ly-icon name="calendar"></ly-icon> {{ task.createdSinceWeeks }}w
      </span>
      <span
        v-if="task.restartedCount > 0"
        v-tooltip.left="$tc('tasks.item.restarted', task.restartedCount, { count: task.restartedCount })"
      >
        <ly-icon name="repeat"></ly-icon> {{ task.restartedCount }}
      </span>
    </ly-badge>

    <ly-button
      v-if="!task.isBacklogged"
      :type="task.isFinished ? 'ghost' : 'default'"
      @click="toggleFinishTask"
    >
      {{ task.isFinished ? $t('tasks.item.markAsUndone') : $t('tasks.item.markAsDone') }}
    </ly-button>
    <template v-else>
      <ly-button v-if="!task.plannedAt" @click="start">
        {{ $t('tasks.item.plan') }}
      </ly-button>
      <ly-button v-else @click="start">
        {{ $t('tasks.item.replan') }}
      </ly-button>
    </template>

    <popover>
      <ly-button
        slot="toggle"
        :disabled="task.isFinished"
        type="ghost"
        icon="ellipsis-h"
      >
      </ly-button>

      <template slot="menu">
        <popover-item :action="() => { this.editMode = true }">{{ $t('tasks.item.edit') }}</popover-item>
        <popover-item :action="confirmAbandon">{{ $t('tasks.item.abandon') }}</popover-item>
      </template>
    </popover>
  </ly-list-item>
</template>

<script>
  import TaskEditForm from './TaskEditForm'

  export default {
    props: {
      'task': { type: Object, required: true },
      'notoggle': { type: Boolean },
      'hideProjectBadge': { type: Boolean },
    },

    components: {
      TaskEditForm,
    },

    data () {
      return {
        editMode: false,
      }
    },

    methods: {
      toggleFinishTask () {
        const { task } = this
        if (task.isFinished) {
          this.$store.dispatch('tasks/start', { task })
        } else {
          this.$store.dispatch('tasks/finish', { task })
        }
      },

      start () {
        const { task } = this
        this.$store.dispatch('tasks/start', { task })
      },

      confirmAbandon () {
        const { task } = this
        if (window.confirm(this.$t('tasks.item.confirmAbandon'))) {
          this.$store.dispatch('tasks/abandon', { task })
        }
      },
    },
  }
</script>

<style lang="scss">
  .ly-list-item-task {
    transition: color .2s ease-in-out;

    &.finished,
    &.finished a,
    &.finished .ly-button {
      color: $ly-color-grey-50;
    }
    &.finished .ly-badge-indicators {
      display: none;
    }

    .popover { visibility: hidden; }
    &:hover .popover { visibility: visible; }
  }

  @media(max-width: $small-screen-width) {
    .ly-list-item-task .popover {
      display: none;
    }
  }
</style>
