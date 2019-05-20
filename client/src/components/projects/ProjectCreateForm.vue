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
        :placeholder="$t('projects.createForm.placeholder')"
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-button
        v-if="created"
        class="success"
        icon="check"
        :type="main ? 'primary' : 'default'"
        submit
      >
        {{ $t('projects.createForm.created') }}
      </ly-button>
      <ly-button v-else :type="main ? 'primary' : 'default'" submit>
        {{ $t('projects.createForm.submit') }}
      </ly-button>

      <ly-button v-if="!nocancel" @click="$emit('cancel')">
        {{ $t('projects.createForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      initialName: { type: String },
      main: { type: Boolean },
      autofocus: { type: Boolean },
      nocancel: { type: Boolean },
    },

    data () {
      return {
        name: this.initialName || '',
        created: false,
      }
    },

    methods: {
      create () {
        if (this.createdTimeout) {
          clearTimeout(this.createdTimeout)
        }

        this.$store
          .dispatch('projects/create', {
            name: this.name,
          })
          .then((projectId) => {
            const { nameInput } = this.$refs
            this.name = ''
            this.cleanErrors()
            this.created = true
            this.createdTimeout = setTimeout(() => { this.created = false }, 2000)
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

<style lang="scss" scoped>
  .ly-button {
    transition: color .2s ease-in-out;

    &.ly-button-default.success {
      color: $ly-color-green-70;
    }
  }
</style>
