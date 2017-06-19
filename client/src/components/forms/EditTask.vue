<template>
  <form @submit.prevent="update">
    <div :class="['form-group-control', { invalid: isInError('Task', 'label') }]">
      <text-field id="label" v-model="label" ref="labelInput" autocomplete="off" />
      <div v-if="isInError('Task', 'label')" class="form-group-tip">
        {{ getErrors('Task', 'label') }}
      </div>
    </div>

    <btn submit>{{ $t('forms.editTask.submit') }}</btn>
    <btn v-if="onCancel" type="cancel" @click="onCancel">
      {{ $t('forms.editTask.cancel') }}
    </btn>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    mixins: [ErrorsHandler],

    props: {
      'task': { type: Object, required: true },
      'onCancel': { type: Function },
      'onSuccess': { type: Function },
      'autoFocus': { type: Boolean },
    },

    data () {
      return {
        label: this.task.label,
      }
    },

    methods: {
      update () {
        this.$store
          .dispatch('tasks/update', {
            task: this.task,
            label: this.label,
          })
          .then((taskId) => {
            this.cleanErrors()
            this.onSuccess && this.onSuccess()
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
