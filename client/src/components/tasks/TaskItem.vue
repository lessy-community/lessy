<template>
  <task-edit-form
    v-if="editMode"
    autoFocus
    :task="task"
    :onSuccess="() => { this.editMode = false }"
    :onCancel="() => { this.editMode = false }"
  ></task-edit-form>
  <ly-list-item v-else name="task" :with-handle="!nohandle" :class="[{ finished: task.isFinished }]">
    <ly-list-item-adapt>
      <span v-html="task.formattedLabel"></span>
      <ly-badge v-if="project && !hideProjectBadge" size="small">
        <router-link :to="project.urlShow">
          {{ project.name }}
        </router-link>
      </ly-badge>
    </ly-list-item-adapt>

    <ly-badge
      name="indicators"
      v-if="task.startedSinceWeeks > 0 || task.replannedCount > 0"
      :type="{ alert: task.startedSinceWeeks > 2 || task.replannedCount > 2, warning: task.startedSinceWeeks === 2 || task.replannedCount === 2 }"
    >
      <span
        v-if="task.startedSinceWeeks > 0"
        v-tooltip.top="$tc('tasks.item.startedSinceWeeks', task.startedSinceWeeks, { count: task.startedSinceWeeks })"
      >
        <ly-icon name="calendar"></ly-icon>
        {{ $t('tasks.item.week', { count: task.startedSinceWeeks }) }}
      </span>
      <span
        v-if="task.replannedCount > 0"
        v-tooltip.top="$tc('tasks.item.replanned', task.replannedCount, { count: task.replannedCount })"
      >
        <ly-icon name="repeat"></ly-icon> {{ task.replannedCount }}
      </span>
    </ly-badge>

    <ly-button
      v-if="!notoggle && task.isForToday"
      :type="task.isFinished ? 'ghost' : 'default'"
      @click="toggleFinishTask"
    >
      {{ task.isFinished ? $t('tasks.item.markAsUndone') : $t('tasks.item.markAsDone') }}
    </ly-button>

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
      nohandle: { type: Boolean },
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

    computed: {
      project: function () {
        const { projectId } = this.task
        return this.$store.getters['projects/findById'](projectId)
      },
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
