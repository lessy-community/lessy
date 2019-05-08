<template>
  <div class="tasks-chart">
    <div class="tasks-chart-data">
      <div
        v-for="(day, index) in dataDays"
        :key="index"
        :class="['tasks-chart-axis-day', { selected: day.selected }]"
      >
        <div class="tasks-chart-data-created">
          <div v-if="day.nbCreated > 0" class="tasks-chart-data-bar" :style="{ height: heightCreated(day) }">
            {{ day.nbCreated }}
          </div>
        </div>

        <div class="tasks-chart-data-finished">
          <div v-if="day.nbFinished > 0" class="tasks-chart-data-bar" :style="{ height: heightFinished(day) }">
            {{ day.nbFinished }}
          </div>
        </div>

        <div class="tasks-chart-label-day">
          {{ day.label }}
        </div>
      </div>
    </div>

    <div class="tasks-chart-labels">
      <div class="tasks-chart-label-created">
        {{ $t('tasks.chart.created') }}
      </div>
      <div class="tasks-chart-label-finished">
        {{ $t('tasks.chart.finished') }}
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      days: { type: Array, required: true },
      createdByDays: { type: Object, required: true },
      finishedByDays: { type: Object, required: true },
      selected: { type: Object },
    },

    computed: {
      dataDays () {
        let data = []

        this.days.forEach((day) => {
          const key = day.format('YYYY-MM-DD')
          data.push({
            nbCreated: (this.createdByDays[key] || []).length,
            nbFinished: (this.finishedByDays[key] || []).length,
            label: this.$d(day.toDate(), 'abbr'),
            selected: key === this.selected.format('YYYY-MM-DD'),
          })
        })

        return data
      },

      maxTasks () {
        return Math.max(...this.dataDays.map((day) => (
          Math.max(day.nbCreated, day.nbFinished)
        )))
      },
    },

    methods: {
      heightCreated (day) {
        if (this.maxTasks > 0) {
          return (day.nbCreated * 100 / this.maxTasks) + '%'
        } else {
          return '0%'
        }
      },

      heightFinished (day) {
        if (this.maxTasks > 0) {
          return (day.nbFinished * 100 / this.maxTasks) + '%'
        } else {
          return '0%'
        }
      },
    },
  }
</script>

<style lang="scss">
  .tasks-chart-data {
    display: flex;
  }

  .tasks-chart-axis-day {
    width: 6.5%;
    height: 20rem;
    margin-bottom: 3rem;
    padding-top: 1rem;

    text-align: center;

    background-color: $ly-color-grey-20;
    border-bottom: .25rem solid $ly-color-grey-30;

    + .tasks-chart-axis-day {
      border-left: .25rem solid $ly-color-grey-30;
    }

    .tasks-chart-data-created,
    .tasks-chart-data-finished {
      position: relative;

      display: inline-block;
      height: 100%;
      width: 35%;
      padding-left: 5%;
      padding-right: 5%;

      color: $ly-color-white;
      text-align: center;
      font-weight: bold;
    }
    .tasks-chart-data-created .tasks-chart-data-bar,
    .tasks-chart-data-finished .tasks-chart-data-bar {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;

      border-radius: .25rem .25rem 0 0;
    }

    .tasks-chart-label-day {
      text-align: center;
      font-size: .9rem;
      color: $ly-color-grey-50;
    }
  }

  .tasks-chart-labels {
    .tasks-chart-label-created,
    .tasks-chart-label-finished {
      display: inline;
      padding-left: 1rem;
      padding-right: 2rem;
    }

    .tasks-chart-label-created::before,
    .tasks-chart-label-finished::before {
      content: "";

      vertical-align: middle;

      display: inline-block;
      width: 1rem;
      height: 1rem;
      margin-right: .25rem;

      border-radius: .25rem;
    }
  }

  .tasks-chart-label-created::before,
  .tasks-chart-data-created .tasks-chart-data-bar {
    background-color: $ly-color-grey-50;
  }
  .tasks-chart-label-finished::before,
  .tasks-chart-data-finished .tasks-chart-data-bar {
    background-color: $ly-color-grey-90;
  }

  .tasks-chart-axis-day.selected {
    border-bottom-color: $ly-color-pine-90;

    .tasks-chart-data-created .tasks-chart-data-bar {
      background-color: $ly-color-pine-50;
    }
    .tasks-chart-data-finished .tasks-chart-data-bar {
      background-color: $ly-color-pine-90;
    }
    .tasks-chart-label-day {
      font-size: 1rem;
      color: $ly-color-grey-90;
    }
  }
</style>
