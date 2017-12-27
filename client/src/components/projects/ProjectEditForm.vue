<template>
  <ly-form @submit="update" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="name"
        v-model="name"
        :label="$t('projects.editForm.nameLabel')"
        :error="getErrors('/project/name')"
        pattern=".{1,100}"
        :caption="$t('projects.editForm.nameCaption')"
        autocomplete="off"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group v-if="project.isStarted">
      <ly-form-input
        type="date"
        name="due-at"
        v-model="dueAt"
        :label="$t('projects.editForm.dueLabel')"
        :error="getErrors('/project/due_at')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-form-textarea
        name="description"
        v-model="description"
        :label="$t('projects.editForm.descriptionLabel')"
        :error="getErrors('/project/description')"
        :caption="$t('projects.editForm.descriptionCaption')"
      ></ly-form-textarea>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('projects.editForm.submit') }}
      </ly-button>
      <ly-button @click="onCancel">
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
      'project': { type: Object, required: true },
      'onSuccess': { type: Function, required: true },
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        name: this.project.name,
        description: this.project.description,
        dueAt: this.project.dueAt,
        error: '',
      }
    },

    methods: {
      update () {
        this.$store
          .dispatch('projects/update', {
            project: this.project,
            name: this.name,
            description: this.description,
            dueAt: this.dueAt,
          })
          .then(this.onSuccess)
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
