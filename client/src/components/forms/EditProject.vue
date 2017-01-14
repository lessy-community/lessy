<template>
  <form @submit.prevent="update">
    <div v-if="error">
      {{ error }}
    </div>

    <div>
      <label for="name">Name *</label>
      <input v-model="name" type="text" id="name" required />
    </div>

    <div>
      <label for="description">Description</label>
      <textarea v-model="description" id="description"></textarea>
    </div>

    <btn submit>Validate</btn>
    <btn type="cancel" @click="onCancel">Cancel</btn>
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
          })
          .then(this.onSuccess)
          .catch((error) => {
            this.error = error.data.message
          })
      },
    },

  }
</script>
