<script>
  import { Bar } from 'vue-chartjs'

  export default Bar.extend({
    props: ['data', 'options'],
    mounted () {
      this.renderChart(
        this.data,
        {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            yAxes: [{
              gridLines: {
                display: true,
              },
              ticks: {
                stepSize: 1,
              },
            }],
            xAxes: [{
              categoryPercentage: 0.9,
              barPercentage: 1,
            }],
          },
        }
      )
    }
  })
</script>
