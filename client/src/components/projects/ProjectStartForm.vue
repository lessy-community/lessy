<template>
  <ly-form @submit="start" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="date"
        name="due-at"
        v-model="dueAt"
        :label="$t('projects.startForm.dueLabel')"
        :error="getErrors('/project/due_at')"
        :caption="$t('projects.startForm.dueCaption')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('projects.startForm.submit') }}
      </ly-button>
      <ly-button @click="$emit('cancel')">
        {{ $t('projects.startForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import moment from 'moment'
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      project: { type: Object, required: true },
    },

    data () {
      return {
        dueAt: moment().add(2, 'weeks').toDate(),
      }
    },

    methods: {
      start () {
        this.$store
          .dispatch('projects/start', {
            project: this.project,
            dueAt: this.dueAt,
          })
          .then(() => this.$emit('success'))
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
