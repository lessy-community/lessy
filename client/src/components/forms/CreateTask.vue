<template>
  <form @submit.prevent="create">
    <div :class="['form-group-control', { invalid: isInError('Task', 'label') }]">
      <text-field id="label" v-model="label" ref="labelInput" autocomplete="off" />
      <div v-if="isInError('Task', 'label')" class="form-group-tip">
        {{ getErrors('Task', 'label') }}
      </div>
    </div>

    <btn submit>{{ $t('forms.createTask.submit') }}</btn>
    <btn v-if="onCancel" type="cancel" @click="onCancel">
      {{ $t('forms.createTask.cancel') }}
    </btn>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'create-task-form',

    mixins: [ErrorsHandler],

    props: {
      'onCancel': { type: Function },
      'autoFocus': { type: Boolean },
      'plannedAt': { type: Object },
      'projectId': { type: Number },
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
