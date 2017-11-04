<template>
  <app-page name="tasks-statistics">
    <line-chart :name="$t('tasks.statisticsPage.chartName')" :data="chartData()"></line-chart>
  </app-page>
</template>

<script>
  import Moment from 'moment'
  import { extendMoment } from 'moment-range'
  const moment = extendMoment(Moment)

  import LineChart from './LineChart'

  import { mapGetters } from 'vuex'

  export default {
    components: {
      LineChart,
    },

    computed: {
      ...mapGetters({
        countFinishedTasksByDays: 'tasks/countFinishedByDays',
        countCreatedTasksByDays: 'tasks/countCreatedByDays',
      }),
    },

    methods: {
      chartData () {
        const lastWeek = moment().subtract(2, 'weeks')
        const today = moment()
        const period = moment.range(lastWeek, today)
        const days = Array.from(period.by('day'))

        return {
          labels: days.map(date => date.format('DD MMM')),
          datasets: [
            {
              label: 'created tasks',
              backgroundColor: '#0080b0',
              borderColor: '#0080b0',
              pointBorderColor: '#fff',
              pointRadius: 6,
              pointBorderWidth: 3,
              fill: false,
              lineTension: 0,
              data: days.map(date => this.countCreatedTasksByDays[date.format('YYYY-MM-DD')] || 0),
            },
            {
              label: 'finished tasks',
              backgroundColor: '#5cb860',
              borderColor: '#5cb860',
              pointBorderColor: '#fff',
              pointRadius: 6,
              pointBorderWidth: 3,
              fill: false,
              lineTension: 0,
              data: days.map(date => this.countFinishedTasksByDays[date.format('YYYY-MM-DD')] || 0),
            },
          ],
        }
      },
    },
  }
</script>
