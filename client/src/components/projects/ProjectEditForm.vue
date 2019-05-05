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
      <ly-button @click="$emit('cancel')">
        {{ $t('projects.editForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      project: { type: Object, required: true },
    },

    data () {
      return {
        name: this.project.name,
        description: this.project.description,
      }
    },

    methods: {
      update () {
        this.$store
          .dispatch('projects/update', {
            project: this.project,
            name: this.name,
            description: this.description,
          })
          .then(() => this.$emit('success'))
          .catch(this.setFailureErrors)
      },
    },
  }
</script>
