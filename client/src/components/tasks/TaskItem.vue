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
      v-if="task.startedSinceWeeks > 0 || task.restartedCount > 0"
      :type="{ alert: task.startedSinceWeeks > 2 || task.restartedCount > 2, warning: task.startedSinceWeeks === 2 || task.restartedCount === 2 }"
    >
      <span
        v-if="task.startedSinceWeeks > 0"
        v-tooltip.top="$tc('tasks.item.startedSinceWeeks', task.startedSinceWeeks, { count: task.startedSinceWeeks })"
      >
        <ly-icon name="calendar"></ly-icon> {{ task.startedSinceWeeks }}w
      </span>
      <span
        v-if="task.restartedCount > 0"
        v-tooltip.top="$tc('tasks.item.restarted', task.restartedCount, { count: task.restartedCount })"
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
      <ly-button
        v-if="!task.plannedAt"
        @click="start"
      >
        {{ $t('tasks.item.plan') }}
      </ly-button>
      <ly-button
        v-else
        @click="start"
        v-tooltip.top="$t('tasks.item.dueOn', { date: task.plannedAtLabel })"
      >
        {{ $t('tasks.item.replan') }}
      </ly-button>
    </template>

    <ly-popover>
      <ly-button
        slot="toggle"
        :disabled="task.isFinished"
        type="ghost"
        icon="ellipsis-h"
      >
      </ly-button>

      <template slot="menu">
        <ly-popover-item @click="() => { this.editMode = true }">{{ $t('tasks.item.edit') }}</ly-popover-item>
        <ly-popover-item @click="activeModal = 'abandon'">{{ $t('tasks.item.abandon') }}</ly-popover-item>
        <ly-popover-separator></ly-popover-separator>
        <ly-popover-item @click="activeModal = 'attach'">{{ $t('tasks.item.attachToProject') }}</ly-popover-item>
        <ly-popover-item @click="activeModal = 'transform'">{{ $t('tasks.item.transformInProject') }}</ly-popover-item>
      </template>
    </ly-popover>

    <div>
      <task-confirm-abandon-modal
        v-if="activeModal === 'abandon'"
        :task="task"
        @close="activeModal = null"
      ></task-confirm-abandon-modal>

      <task-attach-project-modal
        v-if="activeModal === 'attach'"
        :task="task"
        @close="activeModal = null"
      ></task-attach-project-modal>

      <task-transform-in-project-modal
        v-if="activeModal === 'transform'"
        :task="task"
        @close="activeModal = null"
      ></task-transform-in-project-modal>
    </div>
  </ly-list-item>
</template>

<script>
  import TaskEditForm from './TaskEditForm'
  import TaskConfirmAbandonModal from './TaskConfirmAbandonModal'
  import TaskAttachProjectModal from './TaskAttachProjectModal'
  import TaskTransformInProjectModal from './TaskTransformInProjectModal'

  export default {
    props: {
      task: { type: Object, required: true },
      notoggle: { type: Boolean },
      hideProjectBadge: { type: Boolean },
    },

    components: {
      TaskEditForm,
      TaskConfirmAbandonModal,
      TaskAttachProjectModal,
      TaskTransformInProjectModal,
    },

    data () {
      return {
        editMode: false,
        activeModal: null,
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
    &.finished .v-popover {
      visibility: hidden;
    }
  }

  @media(max-width: $small-screen-width) {
    .ly-list-item-task .v-popover {
      display: none;
    }
  }
</style>
