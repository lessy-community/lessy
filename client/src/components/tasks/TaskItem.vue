<template>
  <task-edit-form
    v-if="editMode"
    autoFocus
    :task="task"
    :onSuccess="stopEditMode"
    :onCancel="stopEditMode"
  ></task-edit-form>
  <list-item v-else :class="['task-item', { finished: task.isFinished }]">
    <container row align="center">
      <span class="my-handle">::</span>

      <a v-if="!notoggle" href="#" @click.prevent="toggleFinishTask" class="toggle">
        <ly-icon
          ref="toggle"
          v-tooltip.top="$t('tasks.item.toggle')"
          :name="task.isFinished ? 'check-circle': 'circle-thin'"
        ></ly-icon>
      </a>
      <div class="label adapt">
        <span v-html="task.formattedLabel"></span>
        <ly-badge v-if="task.projectName && !hideProjectBadge">
          <router-link :to="task.urlProjectShow">
            {{ task.projectName }}
          </router-link>
        </ly-badge>
        <ly-badge
          v-if="task.createdSinceWeeks > 0"
          v-tooltip.top="$tc('tasks.item.createdSinceWeeks', task.createdSinceWeeks, { count: task.createdSinceWeeks })"
          :type="{ warning: task.createdSinceWeeks === 2, alert: task.createdSinceWeeks > 2 }"
        >
          <ly-icon name="calendar"></ly-icon> {{ task.createdSinceWeeks }}w
        </ly-badge>
        <ly-badge
          v-if="task.restartedCount > 0"
          v-tooltip.top="$tc('tasks.item.restarted', task.restartedCount, { count: task.restartedCount })"
          :type="{ warning: task.restartedCount === 2, alert: task.restartedCount > 2 }"
        >
          <ly-icon name="repeat"></ly-icon> {{ task.restartedCount }}
        </ly-badge>
      </div>

      <popover v-if="!task.isFinished">
        <ly-button
          slot="toggle"
          v-tooltip.top="$t('tasks.item.more')"
          type="ghost"
          icon="ellipsis-h"
        >
        </ly-button>

        <template slot="menu">
          <popover-item :action="startEditMode">{{ $t('tasks.item.edit') }}</popover-item>
          <popover-item :action="confirmAbandon">{{ $t('tasks.item.abandon') }}</popover-item>
        </template>
      </popover>

      <template v-if="task.isBacklogged">
        <ly-button
          v-if="task.isBacklogged && !task.plannedAt"
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
    </container>
  </list-item>
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

      startEditMode () {
        this.editMode = true
      },

      stopEditMode () {
        this.editMode = false
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
  .task-item {
    .my-handle {
      padding: 5px;
      visibility: hidden;
      cursor: move;
    }
    &:hover .my-handle {
      visibility: visible;
    }

    .toggle {
      margin-top: -1px;
      margin-right: .5rem;

      font-size: 1.5rem;
      line-height: 1.5rem;
    }

    .label {
      white-space: normal;
      transition: color .2s ease-in-out;
    }

    &:nth-child(even) {
      background-color: #f4f4f4;
    }

    &.finished .label {
      color: $ly-color-grey-50;
    }
    &.finished .ly-badge {
      display: none;
    }
    &.finished .toggle {
      color: #999;
    }

    .ly-button {
      margin: .25rem 5px;
    }

    .popover { visibility: hidden; }
    &:hover .popover { visibility: visible; }
  }

  @media(max-width: $small-screen-width) {
    .task-item {
      .container.row {
        flex-direction: row;
      }

      .my-handle,
      .popover {
        display: none;
      }
    }
  }
</style>
