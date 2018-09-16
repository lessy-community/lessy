<template>
  <ly-list-item
    name="task"
    selectable
    @select="$emit('select')"
  >
    <ly-list-item-adapt>
      <span v-html="task.formattedLabel"></span>
      <ly-badge v-if="project" size="small">
        {{ project.name }}
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
  </ly-list-item>
</template>

<script>
  export default {
    props: {
      task: { type: Object, required: true },
    },

    computed: {
      project: function () {
        const { projectId } = this.task
        return this.$store.getters['projects/findById'](projectId)
      },
    },
  }
</script>
