<template>
  <ly-badge
    name="indicators"
    v-if="task.startedSinceWeeks > 0 || task.replannedCount > 0"
    :type="{ alert: task.startedSinceWeeks > 2 || task.replannedCount > 2, warning: task.startedSinceWeeks === 2 || task.replannedCount === 2 }"
  >
    <span
      v-if="task.startedSinceWeeks > 0"
      v-tooltip.top="$tc('tasks.indicators.startedSinceWeeks', task.startedSinceWeeks, { count: task.startedSinceWeeks })"
    >
      <ly-icon name="calendar"></ly-icon>
      {{ $t('tasks.indicators.week', { count: task.startedSinceWeeks }) }}
    </span>
    <span
      v-if="task.replannedCount > 0"
      v-tooltip.top="$tc('tasks.indicators.replanned', task.replannedCount, { count: task.replannedCount })"
    >
      <ly-icon name="repeat"></ly-icon> {{ task.replannedCount }}
    </span>
  </ly-badge>
</template>

<script>
  export default {
    props: {
      task: { type: Object, required: true },
    },
  }
</script>
