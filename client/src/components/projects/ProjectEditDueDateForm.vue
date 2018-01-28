<template>
  <ly-form @submit="update" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="date"
        name="due-at"
        v-model="dueAt"
        :label="$t('projects.editForm.dueLabel')"
        :error="getErrors('/project/due_at')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('projects.editForm.submit') }}
      </ly-button>
      <ly-button @click="$emit('cancel')">
        {{ $t('projects.editForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      project: { type: Object, required: true },
    },

    data () {
      return {
        dueAt: this.project.dueAt,
      }
    },

    methods: {
      update () {
        this.$store
          .dispatch('projects/update', {
            project: this.project,
            dueAt: this.dueAt,
          })
          .then(() => this.$emit('success'))
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
