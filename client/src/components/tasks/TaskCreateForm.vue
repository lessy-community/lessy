<template>
  <ly-form @submit="create" size="fluid" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="label"
        v-model="label"
        ref="labelInput"
        :caption="showWarning ? $t('tasks.createForm.warningTooMany') : ''"
        :error="getErrors('/task/label')"
        autocomplete="off"
        required
        :placeholder="$t('tasks.createForm.placeholder')"
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('tasks.createForm.submit') }}
      </ly-button>
      <ly-button v-if="onCancel" @click="onCancel">
        {{ $t('tasks.createForm.cancel') }}
      </ly-button>
      <span :class="['text-success', { show: created }]">
        <ly-icon name="check"></ly-icon>
        {{ $t('tasks.createForm.created') }}
      </span>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      'onSuccess': { type: Function },
      'onCancel': { type: Function },
      'autoFocus': { type: Boolean },
      'plannedAt': { type: Object },
      'projectId': { type: Number },
      'show-warning': { type: Boolean },
    },

    data () {
      return {
        label: '',
        created: false,
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
            this.created = true
            setTimeout(() => { this.created = false }, 5000)
            labelInput && labelInput.focus()
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

<style lang="scss" scoped>
  .text-success {
    opacity: 0;

    transition: opacity .2s ease-in-out;

    &.show {
      opacity: 1;
    }
  }
</style>
