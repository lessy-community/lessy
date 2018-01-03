<template>
  <ly-card>
    <template slot="header">
      <router-link :to="project.urlShow">{{ project.name }}</router-link>
    </template>

    <project-timeline :project="project" disable-actions></project-timeline>

    <template slot="footer">
      <span :class="{
          'text-alert': tasks.length === 0,
          'text-warning': tasks.length === finishedTasks.length,
      }">
        {{ $tc('projects.card.tasksCount', tasks.length, {
          finishedCount: finishedTasks.length,
          totalCount: tasks.length,
        }) }}
        <small v-if="tasks.length === 0 || tasks.length === finishedTasks.length">
          <br />
          <ly-icon name="exclamation-circle"></ly-icon>
          {{ $t('projects.card.shouldAddTasks') }}
        </small>
      </span>
    </template>
  </ly-card>
</template>

<script>
  import moment from 'moment'
  import ProjectTimeline from './ProjectTimeline'

  export default {
    props: {
      project: { type: Object, required: true },
    },

    components: {
      ProjectTimeline,
    },

    data () {
      return {
        today: moment().unix(),
      }
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
