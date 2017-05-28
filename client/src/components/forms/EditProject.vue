<template>
  <form @submit.prevent="update">
    <div v-if="isInError('Project')" class="form-errors">
      {{ getErrors('Project') }}
    </div>

    <form-group
      :label="$t('forms.editProject.nameLabel')"
      target="name"
      required
      :tip="getErrors('Project', 'name') || $t('forms.editProject.nameTip')"
      :invalid="isInError('Project', 'name')"
    >
      <text-field id="name" v-model="name" pattern="[\w\-]{1,100}" required />
    </form-group>

    <form-group
      v-if="project.isStarted"
      :label="$t('forms.editProject.dueLabel')"
      target="due-at"
      required
      :tip="getErrors('Project', 'dueAt')"
      :invalid="isInError('Project', 'dueAt')"
    >
      <date-field id="due-at" v-model="dueAt" required />
    </form-group>

    <form-group
      :label="$t('forms.editProject.descriptionLabel')"
      target="description"
      :tip="getErrors('Project', 'description') || $t('forms.editProject.descriptionTip')"
      :invalid="isInError('Project', 'description')"
    >
      <text-field id="description" v-model="description" multiplelines />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.editProject.submit') }}</btn>
      <btn type="cancel" @click="onCancel">{{ $t('forms.editProject.cancel') }}</btn>
    </form-group>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'edit-project-form',

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

<style scoped>

  .form-errors {
    margin-bottom: 20px;

    text-align: center;

    color: #ff2c00;
  }

</style>
