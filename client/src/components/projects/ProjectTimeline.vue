<template>
  <div :class="['project-timeline', `project-timeline-${status}`]">
    <div class="project-timeline-labels">
      <span
        v-if="project.startedAt"
        class="project-timeline-labels-start"
        v-tooltip.top="$t('projects.timeline.startedOn', { date: startLabel })"
      >
        {{ startShortLabel }}
      </span>

      <span v-if="project.state === 'newed'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.notStarted') }}
      </span>
      <span v-else-if="project.state === 'paused'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.pausedOn', { date: project.pausedAtLabel }) }}
      </span>
      <span v-else-if="project.state === 'finished'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.finishedOn', { date: project.finishedAtLabel }) }}
      </span>
      <span v-else-if="status === 'late'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.late') }}
      </span>
      <span v-else-if="status === 'due-today'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.dueToday') }}
      </span>
      <span
        v-else
        class="project-timeline-labels-diff"
      >
        {{ $tc('projects.timeline.diff', numberDaysDiff, { days: numberDaysDiff }) }}<br />
        <small>{{ $t('projects.timeline.untilDueDate') }}</small>
      </span>

      <ly-button
        v-if="!disableActions && project.isStarted"
        type="ghost"
        icon="pencil"
        size="small"
        v-tooltip.top="$t('projects.timeline.dueOnEdit')"
        @click="activeModal = 'editDueDate'"
      >
      </ly-button>
      <span
        v-if="project.dueAt"
        class="project-timeline-labels-end"
        v-tooltip.top="$t('projects.timeline.dueOn', { date: endLabel })"
      >
        {{ endShortLabel }}
      </span>
    </div>

    <div class="project-timeline-bar">
      <div
        class="project-timeline-bar-progression"
        :style="{ right: `${progression}%` }"
      ></div>
    </div>

    <div v-if="!disableActions" class="project-timeline-actions">
      <ly-button
        v-if="project.state === 'newed' && !canStartProject"
        disabled
        v-tooltip.top="$t('projects.timeline.reachedMaxInProgress')"
        type="ghost"
        size="small"
        icon="play"
      >
        {{ $t('projects.timeline.start') }}
      </ly-button>
      <ly-button
        v-else-if="project.state === 'newed'"
        type="ghost"
        size="small"
        icon="play"
        @click="activeModal = 'start'"
      >
        {{ $t('projects.timeline.start') }}
      </ly-button>
      <ly-button
        v-else-if="project.state === 'started'"
        type="ghost"
        size="small"
        icon="pause"
        @click="pauseProject"
      >
        {{ $t('projects.timeline.pause') }}
      </ly-button>
      <ly-button
        v-else-if="project.state === 'paused' && !canStartProject"
        disabled
        v-tooltip.top="$t('projects.timeline.reachedMaxInProgress')"
        type="ghost"
        size="small"
        icon="play"
      >
        {{ $t('projects.timeline.restart') }}
      </ly-button>
      <ly-button
        v-else-if="project.state === 'paused'"
        type="ghost"
        size="small"
        icon="play"
        @click="activeModal = 'start'"
      >
        {{ $t('projects.timeline.restart') }}
      </ly-button>

      <div class="project-timeline-actions-separator"></div>

      <ly-button
        v-if="project.state === 'started'"
        type="ghost"
        size="small"
        icon="check"
        @click="activeModal = 'finish'"
      >
        {{ $t('projects.timeline.finish') }}
      </ly-button>
    </div>

    <project-edit-due-date-modal
      v-if="activeModal === 'editDueDate'"
      :project="project"
      @close="activeModal = null"
    ></project-edit-due-date-modal>

    <project-start-modal
      v-if="activeModal === 'start'"
      :project="project"
      @close="activeModal = null"
    ></project-start-modal>

    <project-finish-modal
      v-if="activeModal === 'finish'"
      :project="project"
      @close="activeModal = null"
    ></project-finish-modal>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import moment from 'moment'

  import ProjectEditDueDateModal from './ProjectEditDueDateModal'
  import ProjectFinishModal from './ProjectFinishModal'
  import ProjectStartModal from './ProjectStartModal'

  export default {
    props: {
      project: { type: Object, required: true },
      'disable-actions': { type: Boolean },
    },

    components: {
      ProjectEditDueDateModal,
      ProjectFinishModal,
      ProjectStartModal,
    },

    data () {
      return {
        today: moment().unix(),
        activeModal: null,
      }
    },

    computed: {
      ...mapGetters({
        canStartProject: 'projects/canStartProject',
      }),

      numberDaysDiff () {
        return moment.unix(this.project.dueAt).diff(moment.unix(this.today).startOf('day'), 'days')
      },

      rawProgression () {
        const { state, dueAt, pausedAt, finishedAt, startedAt } = this.project
        if (state === 'newed') {
          return 100
        }

        const dueDate = moment.unix(dueAt).startOf('day')
        const startedDate = moment.unix(startedAt).startOf('day')
        let referenceDate = moment().startOf('day')
        if (state === 'paused') {
          referenceDate = moment.unix(pausedAt).startOf('day')
        }
        if (state === 'finished') {
          referenceDate = moment.unix(finishedAt).startOf('day')
        }

        return dueDate.diff(referenceDate, 'days') / dueDate.diff(startedDate, 'days') * 100
      },

      progression () {
        return Math.min(100, Math.max(0, this.rawProgression))
      },

      status () {
        if (this.project.state === 'finished') { return 'finished' }
        if (this.rawProgression === 0) { return 'due-today' }
        if (this.rawProgression < 0) { return 'late' }
        if (this.rawProgression < 20) { return 'due-soon' }
        return 'normal'
      },

      startLabel () {
        return moment.unix(this.project.startedAt).format('DD MMMM YYYY')
      },

      endLabel () {
        return moment.unix(this.project.dueAt).format('DD MMMM YYYY')
      },

      startShortLabel () {
        return moment.unix(this.project.startedAt).format('DD MMM')
      },

      endShortLabel () {
        return moment.unix(this.project.dueAt).format('DD MMM')
      },
    },

    methods: {
      pauseProject () {
        this.$store.dispatch('projects/pause', { project: this.project })
      },
    },
  }
</script>

<style lang="scss">
  .project-timeline {
    padding-top: 1rem;
    padding-bottom: 1rem;
  }
  .project-timeline-labels {
    display: flex;
    min-height: 2.5rem;

    align-items: center;

    .project-timeline-labels-start,
    .project-timeline-labels-end {
      color: $ly-color-grey-50;
      font-size: .8rem;
    }
    .project-timeline-labels-diff {
      flex-grow: 1;

      text-align: center;
      line-height: 1.25rem;
    }
  }

  .project-timeline-bar {
    position: relative;

    height: .75rem;

    background-color: $ly-color-grey-30;
    border: 1px solid $ly-color-pine-50;
    border-radius: .25rem;

    .project-timeline-bar-progression {
      position: absolute;
      top: 0;
      bottom: 0;
      left: 0;

      background: linear-gradient(45deg, $ly-color-pine-50 calc(100% - .5rem),
                                         $ly-color-grey-30 calc(100% - .5rem));
      border-radius: calc(.25rem - 1px);
    }
  }

  .project-timeline-actions {
    display: flex;
    margin-top: .75rem;

    .project-timeline-actions-separator {
      flex-grow: 1;
    }

    .ly-button {
      margin-right: 0;
    }
  }

  .project-timeline-finished {
    .project-timeline-labels-diff {
      color: $ly-color-green-70;
      font-weight: bold;
    }
    .project-timeline-bar {
      border-color: $ly-color-green-50;
    }
    .project-timeline-bar-progression {
      background: linear-gradient(45deg, $ly-color-green-50 calc(100% - .5rem),
                                         $ly-color-grey-30 calc(100% - .5rem));
    }
  }

  .project-timeline-due-soon,
  .project-timeline-due-today {
    .project-timeline-labels-diff {
      color: $ly-color-gold-70;
      font-weight: bold;
    }
    .project-timeline-bar {
      border-color: $ly-color-gold-50;
      box-shadow: 0 0 2px $ly-color-gold-50;
    }
    .project-timeline-bar-progression {
      background: linear-gradient(45deg, $ly-color-gold-50 calc(100% - .5rem),
                                         $ly-color-grey-30 calc(100% - .5rem));
    }
  }

  .project-timeline-late {
    .project-timeline-labels-diff {
      color: $ly-color-red-70;
      font-weight: bold;
    }
    .project-timeline-bar {
      border-color: $ly-color-red-70;
      box-shadow: 0 0 2px $ly-color-red-70;
    }
    .project-timeline-bar-progression {
      background: repeating-linear-gradient(45deg, $ly-color-red-50,
                                                   $ly-color-red-50 .5rem,
                                                   $ly-color-red-70 .5rem,
                                                   $ly-color-red-70 1rem);
    }
  }
</style>
