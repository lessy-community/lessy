<template>
  <form @submit.prevent="stop">
    <form-group label="Finished on" target="finished-at" :tip="tip" :invalid="!!error" required>
      <date-field id="finished-at" v-model="finishedAt" />
    </form-group>

    <form-group actions vertical>
      <btn submit>I did it!</btn>
      <btn type="cancel" @click="onCancel">No, I lied :(</btn>
    </form-group>
  </form>
</template>

<script>
  import moment from 'moment'

  export default {

    name: 'finish-project-form',

    props: {
      'project': { type: Object, required: true },
      'onSuccess': { type: Function, required: true },
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        finishedAt: moment().unix(),
        error: '',
      }
    },

    computed: {
      tip () {
        return this.error || 'It cannot be after today'
      },
    },

    methods: {
      stop () {
        this.$store
          .dispatch('projects/finish', {
            project: this.project,
            finishedAt: this.finishedAt,
          })
          .then(this.onSuccess)
          .catch((error) => {
            this.error = error.data.message
          })
      },
    },

  }
</script>
