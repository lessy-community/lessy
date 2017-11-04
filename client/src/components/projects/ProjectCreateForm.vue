<template>
  <form @submit.prevent="create">
    <div :class="['form-group-control', { invalid: isInError('Project', 'name') }]">
      <text-field id="name" v-model="name" pattern="[\w\-]{1,100}" required ref="nameInput" autocomplete="off" />
      <div v-if="isInError('Project', 'name')" class="form-group-tip">{{ getErrors('Project', 'name') }}</div>
    </div>

    <ly-button type="primary" submit>{{ $t('projects.createForm.submit') }}</ly-button>
    <ly-button v-if="onCancel" @click="onCancel">{{ $t('projects.createForm.cancel') }}</ly-button>
  </form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
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
