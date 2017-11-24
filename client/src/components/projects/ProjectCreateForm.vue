<template>
  <ly-form @submit="create">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="name"
        v-model="name"
        ref="nameInput"
        :error="getErrors('Project', 'name')"
        pattern="[\w\-]{1,100}"
        :caption="$t('projects.createForm.nameCaption')"
        autocomplete="off"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-button type="primary" submit>
        {{ $t('projects.createForm.submit') }}
      </ly-button>
      <ly-button v-if="onCancel" @click="onCancel">
        {{ $t('projects.createForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
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
            nameInput && nameInput.focus()
            if (typeof this.onSuccess === 'function') {
              this.onSuccess(projectId)
            }
          })
          .catch((failure) => {
            this.setFailureErrors(failure)
            this.$refs.nameInput.focus()
          })
      },
    },

    mounted () {
      this.$refs.nameInput.focus()
    },
  }
</script>
