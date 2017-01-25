<template>
  <form @submit.prevent="update">
    <div v-if="error">
      {{ error }}
    </div>

    <form-group :label="$t('forms.editProject.nameLabel')" :tip="$t('forms.editProject.nameTip')" target="name" required>
      <text-field id="name" v-model="name" pattern="[\w\-]{1,}" required />
    </form-group>

    <form-group v-if="project.isStarted" :label="$t('forms.editProject.dueLabel')" target="due-at" required>
      <date-field id="due-at" v-model="dueAt" required />
    </form-group>

    <form-group :label="$t('forms.editProject.descriptionLabel')" target="description" :tip="$t('forms.editProject.descriptionTip')">
      <text-field id="description" v-model="description" multiplelines />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.editProject.submit') }}</btn>
      <btn type="cancel" @click="onCancel">{{ $t('forms.editProject.cancel') }}</btn>
    </form-group>
  </form>
</template>

<script>
  export default {

    name: 'edit-project-form',

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
          .catch((error) => {
            this.error = error.data.message
          })
      },
    },

  }
</script>
