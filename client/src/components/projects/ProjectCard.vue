<template>
  <ly-card>
    <template slot="header">
      <router-link :to="project.urlShow">{{ project.name }}</router-link>
    </template>

    <project-timeline :project="project" disable-actions></project-timeline>

    <template slot="footer">
      <span :class="{
          'text-alert': project.tasksCount === 0,
          'text-warning': project.tasksCount === project.finishedTasksCount,
      }">
        {{ $tc('projects.card.tasksCount', project.tasksCount, {
          finishedCount: project.finishedTasksCount,
          totalCount: project.tasksCount,
        }) }}
        <small v-if="project.tasksCount === 0 || project.tasksCount === project.finishedTasksCount">
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
  }
</script>
