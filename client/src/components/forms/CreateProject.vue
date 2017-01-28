<template>
  <form @submit.prevent="create">
    <div :class="['form-group-control', { invalid: isInError('Project', 'name') }]">
      <text-field id="name" v-model="name" pattern="[\w\-]{1,}" required ref="nameInput" />
      <div v-if="isInError('Project', 'name')" class="form-group-tip">{{ getErrors('Project', 'name') }}</div>
    </div>

    <btn submit>{{ $t('forms.createProject.submit') }}</btn>
    <btn v-if="onCancel" type="cancel" @click="onCancel">{{ $t('forms.createProject.cancel') }}</btn>
  </form>
</template>

<script>
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'create-project-form',

    mixins: [ErrorsHandler],

    props: {
      'onSuccess': { type: Function },
      'onCancel': { type: Function },
    },

    data () {
      return {
        name: '',
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
            this.cleanErrors()
            nameInput && nameInput.$el.focus()
            if (typeof this.onSuccess === 'function') {
              this.onSuccess(projectId)
            }
          })
          .catch((failure) => {
            this.setFailureErrors(failure)
            this.$refs.nameInput.$el.focus()
          })
      },
    },

    mounted () {
      this.$refs.nameInput.$el.focus()
    },

  }
</script>
