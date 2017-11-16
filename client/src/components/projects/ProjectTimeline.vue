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
        {{ $t('projects.timeline.pausedOn', { date: project.stoppedAtLabel }) }}
      </span>
      <span v-else-if="project.state === 'finished'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.finishedOn', { date: project.finishedAtLabel }) }}
      </span>
      <span v-else-if="status === 'alert'" class="project-timeline-labels-diff">
        {{ $t('projects.timeline.late') }}
      </span>
      <span
        v-else
        class="project-timeline-labels-diff"
      >
        {{ $tc('projects.timeline.diff', numberDaysDiff, { days: numberDaysDiff }) }}<br />
        <small>{{ $t('projects.timeline.untilDueDate') }}</small>
      </span>

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
        Start
      </ly-button>
      <ly-button
        v-else-if="project.state === 'newed'"
        type="ghost"
        size="small"
        icon="play"
        @click="startProject"
      >
        Start
      </ly-button>
      <ly-button
        v-else-if="project.state === 'started'"
        type="ghost"
        size="small"
        icon="pause"
        @click="pauseProject"
      >
        Pause
      </ly-button>
      <ly-button
        v-else-if="project.state === 'paused' && !canStartProject"
        disabled
        v-tooltip.top="$t('projects.timeline.reachedMaxInProgress')"
        type="ghost"
        size="small"
        icon="play"
      >
        Restart
      </ly-button>
      <ly-button
        v-else-if="project.state === 'paused'"
        type="ghost"
        size="small"
        icon="play"
        @click="restartProject"
      >
        Restart
      </ly-button>

      <div class="project-timeline-actions-separator"></div>

      <ly-button
        v-if="project.state === 'started'"
        type="ghost"
        size="small"
        icon="check"
        @click="finishProject"
      >
        Finish
      </ly-button>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import moment from 'moment'

  export default {
    props: {
      project: { type: Object, required: true },
      'disable-actions': { type: Boolean },
    },

    data () {
      return {
        today: moment().unix(),
      }
    },

    computed: {
      ...mapGetters({
        canStartProject: 'projects/canStartProject',
      }),

      numberDaysDiff () {
        return moment.unix(this.project.dueAt).diff(moment.unix(this.today).startOf('day'), 'days')
      },

      progression () {
        if (this.project.state === 'newed') {
          return 100
        }
        let rawProgression = 0
        if (this.project.state === 'paused') {
          rawProgression = (this.project.dueAt - this.project.stoppedAt) / (this.project.dueAt - this.project.startedAt) * 100
        } else if (this.project.state === 'finished') {
          rawProgression = (this.project.dueAt - this.project.finishedAt) / (this.project.dueAt - this.project.startedAt) * 100
        } else {
          rawProgression = (this.project.dueAt - this.today) / (this.project.dueAt - this.project.startedAt) * 100
        }
        return Math.min(100, Math.max(0, rawProgression))
      },

      status () {
        if (this.project.state === 'finished') { return 'success' }
        if (this.progression <= 0) { return 'alert' }
        if (this.progression < 20) { return 'warning' }
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
      startProject () {
        this.$router.push(this.project.urlStart)
      },

      pauseProject () {
        if (window.confirm(this.$t('projects.timeline.confirmPause'))) {
          this.$store.dispatch('projects/stop', { project: this.project })
        }
      },

      restartProject () {
        this.$router.push(this.project.urlStart)
      },

      finishProject () {
        this.$router.push(this.project.urlFinish)
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

  .project-timeline-success {
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

  .project-timeline-warning {
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

  .project-timeline-alert {
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
