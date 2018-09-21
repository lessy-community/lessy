<template>
  <ly-form @submit="create" size="fluid" :error="getErrors()">
    <ly-form-group stack>
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

      <ly-button
        v-if="created"
        class="success"
        icon="check"
        :type="main ? 'primary' : 'default'"
        submit
      >
        {{ $t('tasks.createForm.created') }}
      </ly-button>
      <ly-button v-else :type="main ? 'primary' : 'default'" submit>
        {{ $t('tasks.createForm.submit') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      plannedAt: { type: Date },
      finishedAt: { type: Date },
      projectId: { type: Number },
      autoFocus: { type: Boolean },
      showWarning: { type: Boolean },
      main: { type: Boolean },
    },

    data () {
      return {
        label: '',
        created: false,
      }
    },

    methods: {
      create () {
        if (this.createdTimeout) {
          clearTimeout(this.createdTimeout)
        }

        this.$store
          .dispatch('tasks/create', {
            label: this.label,
            plannedAt: this.plannedAt,
            finishedAt: this.finishedAt,
            projectId: this.projectId,
          })
          .then((taskId) => {
            const { labelInput } = this.$refs
            this.label = ''
            this.cleanErrors()
            this.created = true
            this.createdTimeout = setTimeout(() => { this.created = false }, 2000)
            labelInput && labelInput.focus()
            this.$emit('success')
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
  .ly-button {
    transition: color .2s ease-in-out;

    &.ly-button-default.success {
      color: $ly-color-green-70;
    }
  }
</style>
