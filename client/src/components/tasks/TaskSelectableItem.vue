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

    <task-indicators :task="task"></task-indicators>
  </ly-list-item>
</template>

<script>
  import TaskIndicators from './TaskIndicators'

  export default {
    props: {
      task: { type: Object, required: true },
    },

    components: {
      TaskIndicators,
    },

    computed: {
      project: function () {
        const { projectId } = this.task
        return this.$store.getters['projects/findById'](projectId)
      },
    },
  }
</script>
