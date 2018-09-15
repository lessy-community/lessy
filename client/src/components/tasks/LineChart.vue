<script>
  import { Line } from 'vue-chartjs'

  export default Line.extend({
    props: ['name', 'data', 'options'],
    mounted () {
      let options = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          position: 'bottom',
          labels: {
            fontSize: 18,
            padding: 50,
            usePointStyle: true,
          },
        },
        tooltips: {
          mode: 'x',
          intersect: false,
          titleFontSize: 14,
          titleMarginBottom: 10,
          bodySpacing: 15,
          xPadding: 10,
          yPadding: 10,
          cornerRadius: 3,
          callbacks: {
            label: function (tooltipItem, data) {
              const number = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
              const label = data.datasets[tooltipItem.datasetIndex].label
              return `  ${number} ${label}`
            },
            labelColor: function (tooltipItem, chart) {
              const { backgroundColor } = chart.config.data.datasets[tooltipItem.datasetIndex]
              return {
                borderColor: backgroundColor,
                backgroundColor,
              }
            },
          },
        },
        scales: {
          yAxes: [{
            gridLines: {
              display: true,
            },
          }],
        },
      }
      if (this.name) {
        options['title'] = {
          display: true,
          text: this.name,
          fontSize: 24,
          padding: 50,
        }
      }
      this.renderChart(
        this.data,
        options,
      )
    }
  })
</script>
