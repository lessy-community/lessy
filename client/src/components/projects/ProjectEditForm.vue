<template>
  <form @submit.prevent="update">
    <div v-if="isInError('Project')" class="form-errors">
      {{ getErrors('Project') }}
    </div>

    <form-group
      :label="$t('projects.editForm.nameLabel')"
      target="name"
      required
      :tip="getErrors('Project', 'name') || $t('projects.editForm.nameTip')"
      :invalid="isInError('Project', 'name')"
    >
      <text-field id="name" v-model="name" pattern="[\w\-]{1,100}" required autocomplete="off" />
    </form-group>

    <form-group
      v-if="project.isStarted"
      :label="$t('projects.editForm.dueLabel')"
      target="due-at"
      required
      :tip="getErrors('Project', 'dueAt')"
      :invalid="isInError('Project', 'dueAt')"
    >
      <date-field id="due-at" v-model="dueAt" required />
    </form-group>

    <form-group
      :label="$t('projects.editForm.descriptionLabel')"
      target="description"
      :tip="getErrors('Project', 'description') || $t('projects.editForm.descriptionTip')"
      :invalid="isInError('Project', 'description')"
    >
      <text-field id="description" v-model="description" multiplelines />
    </form-group>

    <form-group actions>
      <ly-button type="primary" submit>{{ $t('projects.editForm.submit') }}</ly-button>
      <ly-button @click="onCancel">{{ $t('projects.editForm.cancel') }}</ly-button>
    </form-group>
  </form>
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

<style lang="scss" scoped>
  .form-errors {
    margin-bottom: 20px;

    text-align: center;

    color: $color-danger;
  }
</style>
