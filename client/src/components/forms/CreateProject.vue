<template>
  <form @submit.prevent="create">
    <div :class="['form-group-control', { invalid: !!error }]">
      <text-field id="name" v-model="name" pattern="[a-z]{1}([a-z0-9_\-]{1,})*[a-z]{1}" required ref="nameInput" />
      <div v-if="error" class="form-group-tip">{{ error }}</div>
    </div>

    <btn submit>Create</btn>
    <btn type="cancel" @click="onCancel">Cancel</btn>
  </form>
</template>

<script>
  export default {

    name: 'create-project-form',

    props: {
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        name: '',
        error: '',
      }
    },

    methods: {
      create () {
        this.$store
          .dispatch('projects/create', {
            name: this.name,
          })
          .then(() => {
            this.name = ''
            this.error = ''
            this.$refs.nameInput.$el.focus()
          })
          .catch((error) => {
            this.error = error.data.message
            this.$refs.nameInput.$el.focus()
          })
      },
    },

    mounted () {
      this.$refs.nameInput.$el.focus()
    },

  }
</script>
