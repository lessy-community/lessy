<template>
  <ly-form @submit="stop" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="date"
        name="finished-at"
        v-model="finishedAt"
        :label="$t('projects.finishForm.finishedLabel')"
        :caption="$t('projects.finishForm.finishedCaption')"
        :error="getErrors('/project/finished_at')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('projects.finishForm.submit') }}
      </ly-button>
      <ly-button @click="onCancel">
        {{ $t('projects.finishForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import moment from 'moment'
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      'project': { type: Object, required: true },
      'onSuccess': { type: Function, required: true },
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        finishedAt: moment().unix(),
      }
    },

    methods: {
      stop () {
        this.$store
          .dispatch('projects/finish', {
            project: this.project,
            finishedAt: this.finishedAt,
          })
          .then(this.onSuccess)
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
