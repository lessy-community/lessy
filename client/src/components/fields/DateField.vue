<template>
  <input
    type="date"
    :value="dateText"
    :id="id"
    :required="required"
    @input="onDateChange($event.target.value)"
  />
</template>

<script>
  import moment from 'moment'

  const DATE_FORMAT = 'YYYY-MM-DD'

  export default {

    name: 'date-field',

    props: {
      id: { type: String },
      value: { type: Number, required: true },
      required: { type: Boolean },
    },

    data () {
      return {
        dateText: moment.unix(this.value).format(DATE_FORMAT)
      }
    },

    methods: {
      onDateChange (value) {
        const timestamp = moment(value, DATE_FORMAT, true).unix() || 0
        this.$emit('input', timestamp)
      },
    },

  }
</script>
