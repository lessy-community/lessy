export default {
  data () {
    return {
      errors: {},
    }
  },

  methods: {
    setFailureErrors (failure) {
      const { data: { errors } } = failure
      let newErrors = {}

      errors.forEach(error => {
        const pointer = error.source == null ? '/_' : error.source.pointer
        if (newErrors[pointer] == null) {
          newErrors[pointer] = []
        }
        newErrors[pointer] = [
          ...newErrors[pointer],
          error.code,
        ]
      })

      this.errors = newErrors
    },

    getErrors (pointer = '/_') {
      const i18nPointer = pointer.replace(/\//g, '.')
      const i18nBase = `errors${i18nPointer}`
      return this.errors[pointer] && this.errors[pointer].map((errorCode) =>
        this.$t(i18nBase + '.' + errorCode)
      ).join(' ')
    },

    cleanErrors () {
      this.errors = {}
    },
  }
}
