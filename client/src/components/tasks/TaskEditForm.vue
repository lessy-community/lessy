<template>
  <ly-form @submit="update">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="label"
        v-model="label"
        ref="labelInput"
        :error="getErrors('Task', 'label')"
        autocomplete="off"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('tasks.editForm.submit') }}
      </ly-button>
      <ly-button v-if="onCancel" @click="onCancel">
        {{ $t('tasks.editForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

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
            this.$refs.labelInput.focus()
          })
      },
    },

    mounted () {
      if (this.autoFocus) {
        this.$refs.labelInput.focus()
      }
    },
  }
</script>
