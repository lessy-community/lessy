<template>
  <form @submit.prevent="start">
    <div v-if="error">
      {{ error }}
    </div>

    <form-group label="Name">
      <static-field :value="project.name" />
    </form-group>

    <form-group label="Due on" target="due-at">
      <date-field id="due-at" v-model="dueAt" />
    </form-group>

    <form-group actions>
      <btn submit>Start it now</btn>
      <btn type="cancel" @click="onCancel">Cancel</btn>
    </form-group>
  </form>
</template>

<script>
  import moment from 'moment'

  export default {

    name: 'start-project-form',

    props: {
      'project': { type: Object, required: true },
      'onSuccess': { type: Function, required: true },
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        dueAt: moment().add(1, 'month').unix(),
        error: '',
      }
    },

    methods: {
      start () {
        this.$store
          .dispatch('projects/start', {
            project: this.project,
            dueAt: this.dueAt,
          })
          .then(this.onSuccess)
          .catch((error) => {
            this.error = error.data.message
          })
      },
    },

  }
</script>
