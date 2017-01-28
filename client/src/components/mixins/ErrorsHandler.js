export default {
  data () {
    return {
      errors: {},
    }
  },

  methods: {
    setFailureErrors (failure) {
      const { data } = failure
      if (data.code === 'validation_failed') {
        this.errors = {
          [data.resource]: data.errors
        }
      } else if (data.code === 'missing_param') {
        this.errors = {
          [data.resource]: {
            [data.field]: ['missing'],
          },
        }
      } else {
        this.errors = {
          [data.resource]: {
            base: [data.code],
          },
        }
      }
    },

    isInError (resource, field = 'base') {
      const errors = this.errors[resource] && this.errors[resource][field]
      return errors && errors.length > 0
    },

    getErrors (resource, field = 'base') {
      const i18nBase = `errors.${resource}.${field}`
      const errors = this.errors[resource] && this.errors[resource][field]
      return errors && errors.map((error) =>
        this.$t(i18nBase + '.' + error)
      ).join('. ')
    },

    cleanErrors () {
      this.errors = {}
    },
  }
}
