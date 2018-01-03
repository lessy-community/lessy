<template>
  <ly-list-item>
    <ly-list-item-adapt>
      <router-link :to="project.urlShow">
        {{ project.name }}
      </router-link>
    </ly-list-item-adapt>
    <ly-badge size="small">
      {{ $t('projects.itemFinished.finishedLabel', { date: project.finishedAtLabel }) }}
    </ly-badge>
    <ly-badge v-if="tasks.length > 0" size="small">
      {{ $tc('projects.itemFinished.tasksCount', tasks.length, {
        finishedCount: finishedTasks.length,
        totalCount: tasks.length,
      }) }}
    </ly-badge>
  </ly-list-item>
</template>

<script>
  export default {
    props: {
      project: { type: Object, required: true },
    },

    computed: {
      tasks: function () {
        return this.$store.getters['tasks/listForProject'](this.project)
      },

      finishedTasks: function () {
        return this.tasks.filter((task) => task.isFinished)
      },
    },
  }
</script>
