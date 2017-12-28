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
        <ly-popover-item @click="confirmAbandon">{{ $t('tasks.item.abandon') }}</ly-popover-item>
        <ly-popover-separator></ly-popover-separator>
        <ly-popover-item @click="showAttachProjectModal = true">{{ $t('tasks.item.attachToProject') }}</ly-popover-item>
        <ly-popover-item @click="showTransformInProjectModal = true">{{ $t('tasks.item.transformInProject') }}</ly-popover-item>
      </template>
    </ly-popover>

    <div>
      <ly-modal v-if="showAttachProjectModal" :title="$t('tasks.modals.attachProjectTitle')">
        <p class="text-secondary">«&nbsp;{{ task.label }}&nbsp;»</p>

        <task-attach-project-form
          :task="task"
          @success="showAttachProjectModal = false"
          @cancel="showAttachProjectModal = false"
          autofocus
        ></task-attach-project-form>
      </ly-modal>

      <ly-modal v-if="showTransformInProjectModal" :title="$t('tasks.modals.transformInProjectTitle')">
        <project-create-form
          :initialName="task.label"
          @success="onTaskTransformSuccess"
          @cancel="showTransformInProjectModal = false"
          autofocus
        ></project-create-form>
      </ly-modal>
    </div>
  </ly-list-item>
</template>

<script>
  import TaskEditForm from './TaskEditForm'
  import TaskAttachProjectForm from './TaskAttachProjectForm'

  import ProjectCreateForm from 'src/components/projects/ProjectCreateForm'

  export default {
    props: {
      'task': { type: Object, required: true },
      'notoggle': { type: Boolean },
      'hideProjectBadge': { type: Boolean },
    },

    components: {
      TaskEditForm,
      TaskAttachProjectForm,
      ProjectCreateForm,
    },

    data () {
      return {
        editMode: false,
        showAttachProjectModal: false,
        showTransformInProjectModal: false,
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

      onTaskTransformSuccess (projectId) {
        const { task } = this
        const project = this.$store.getters['projects/findById'](projectId)

        this.showTransformInProjectModal = false
        this.$store.dispatch('tasks/abandon', { task })
        if (project) {
          this.$router.push(project.urlShow)
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
