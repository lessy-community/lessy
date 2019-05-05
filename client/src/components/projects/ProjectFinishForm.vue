<template>
  <ly-form @submit="finish" :error="getErrors()">
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
      <ly-button @click="$emit('cancel')">
        {{ $t('projects.finishForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      'project': { type: Object, required: true },
    },

    data () {
      return {
        finishedAt: new Date(),
      }
    },

    methods: {
      finish () {
        this.$store
          .dispatch('projects/finish', {
            project: this.project,
            finishedAt: this.finishedAt,
          })
          .then(() => this.$emit('success'))
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
