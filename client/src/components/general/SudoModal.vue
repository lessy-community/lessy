<template>
  <ly-modal
    :title="$t('general.sudoModal.title')"
    @close="$emit('close')"
  >
    <p>
      {{ $t('general.sudoModal.intro') }}
    </p>

    <ly-form @submit="sudo" :error="getErrors() || getErrors('/user')">
      <ly-form-group>
        <ly-form-input
          ref="passwordInput"
          type="password"
          name="password"
          v-model="password"
          :label="$t('general.sudoModal.passwordLabel')"
          :error="getErrors('/user/password')"
          required
        ></ly-form-input>
      </ly-form-group>

      <ly-form-group>
        <ly-button type="primary" submit>
          {{ $t('general.sudoModal.submit') }}
        </ly-button>
        <ly-button @click="$emit('close')">
          {{ $t('general.sudoModal.cancel') }}
        </ly-button>
      </ly-form-group>
    </ly-form>

    <p class="text-secondary">
      <ly-icon name="info-circle"></ly-icon>
      {{ $t('general.sudoModal.more') }}
    </p>
  </ly-modal>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    data () {
      return {
        password: '',
      }
    },

    methods: {
      sudo () {
        this.$store
          .dispatch('users/sudo', {
            password: this.password,
          })
          .then(() => this.$emit('success'))
          .catch(this.setFailureErrors)
      },
    },

    mounted () {
      this.$refs.passwordInput.focus()
    },
  }
</script>
