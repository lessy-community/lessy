<template>
  <form @submit.prevent="create">
    <div :class="['form-group-control', { invalid: !!error }]">
      <text-field id="name" v-model="name" pattern="[\w\-]{1,}" required ref="nameInput" />
      <div v-if="error" class="form-group-tip">{{ error }}</div>
    </div>

    <btn submit>{{ $t('forms.createProject.submit') }}</btn>
    <btn v-if="onCancel" type="cancel" @click="onCancel">{{ $t('forms.createProject.cancel') }}</btn>
  </form>
</template>

<script>
  export default {

    name: 'create-project-form',

    props: {
      'onSuccess': { type: Function },
      'onCancel': { type: Function },
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
          .then((projectId) => {
            const { nameInput } = this.$refs
            this.name = ''
            this.error = ''
            nameInput && nameInput.$el.focus()
            if (typeof this.onSuccess === 'function') {
              this.onSuccess(projectId)
            }
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
