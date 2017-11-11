<template>
  <form @submit.prevent="create">
    <div :class="['form-group-control', { invalid: isInError('Task', 'label') }]">
      <text-field id="label" v-model="label" ref="labelInput" autocomplete="off" />
      <div v-if="isInError('Task', 'label')" class="form-group-tip">
        {{ getErrors('Task', 'label') }}
      </div>
    </div>

    <ly-button type="primary" submit>{{ $t('tasks.createForm.submit') }}</ly-button>
    <ly-button v-if="onCancel" @click="onCancel">
      {{ $t('tasks.createForm.cancel') }}
    </ly-button>
    <small v-if="showWarning" class="text-secondary">
      {{ $t('tasks.createForm.warningTooMany') }}
    </small>
  </form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      'onCancel': { type: Function },
      'autoFocus': { type: Boolean },
      'plannedAt': { type: Object },
      'projectId': { type: Number },
      'show-warning': { type: Boolean },
    },

    data () {
      return {
        label: '',
      }
    },

    methods: {
      create () {
        const action = this.projectId == null ? 'tasks/create'
                                              : 'tasks/createForProject'
        this.$store
          .dispatch(action, {
            label: this.label,
            plannedAt: this.plannedAt && this.plannedAt.unix(),
            projectId: this.projectId,
          })
          .then((taskId) => {
            const { labelInput } = this.$refs
            this.label = ''
            this.cleanErrors()
            labelInput && labelInput.$el.focus()
          })
          .catch((failure) => {
            this.setFailureErrors(failure)
            this.$refs.labelInput.$el.focus()
          })
      },
    },

    mounted () {
      if (this.autoFocus) {
        this.$refs.labelInput.$el.focus()
      }
    },
  }
</script>
