<template>
  <ly-form @submit="create" :error="getErrors()">
    <ly-form-group>
      <ly-form-input
        type="text"
        name="name"
        v-model="name"
        ref="nameInput"
        :error="getErrors('/project/name') || getErrors('/project/slug')"
        pattern=".{1,100}"
        :caption="$t('projects.createForm.nameCaption')"
        autocomplete="off"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-button type="primary" submit>
        {{ $t('projects.createForm.submit') }}
      </ly-button>
      <ly-button @click="$emit('cancel')">
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
      initialName: { type: String },
      autofocus: { type: Boolean },
    },

    data () {
      return {
        name: this.initialName || '',
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
            this.$emit('success', projectId)
          })
          .catch((failure) => {
            this.setFailureErrors(failure)
            this.$refs.nameInput.focus()
          })
      },
    },

    mounted () {
      if (this.autofocus) {
        this.$refs.nameInput.focus()
      }
    },
  }
</script>
