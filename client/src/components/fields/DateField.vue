<template>
  <input
    type="text"
    :value="dateText"
    :id="id"
    :required="required"
    @input="onDateChange($event.target.value)"
    pattern="\d{1,2} (January|February|March|April|May|June|July|August|September|October|November|December) \d{4}"
  />
</template>

<script>
  import moment from 'moment'

  const DATE_FORMAT = 'DD MMMM YYYY'

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
