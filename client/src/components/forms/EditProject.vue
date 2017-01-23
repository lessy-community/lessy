<template>
  <form @submit.prevent="update">
    <div v-if="error">
      {{ error }}
    </div>

    <form-group label="Name" tip="Only lowercase letters, underscore and dash" target="name" required>
      <text-field id="name" v-model="name" pattern="[\w\-]{1,}" required />
    </form-group>

    <form-group v-if="project.isStarted" label="Due on" target="due-at" required>
      <date-field id="due-at" v-model="dueAt" required />
    </form-group>

    <form-group label="Description" target="description" tip="Description supports Markdown">
      <text-field id="description" v-model="description" multiplelines />
    </form-group>

    <form-group actions>
      <btn submit>Validate</btn>
      <btn type="cancel" @click="onCancel">Cancel</btn>
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
