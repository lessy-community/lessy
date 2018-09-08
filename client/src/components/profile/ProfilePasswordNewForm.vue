<template>
  <ly-form @submit="changePassword">
    <ly-form-group>
      <ly-form-input
        type="password"
        name="password"
        v-model="password"
        :label="$t('profile.passwordNewForm.passwordLabel')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group>
      <ly-button type="primary" submit>
        {{ $t('profile.passwordNewForm.submit') }}
      </ly-button>
    </ly-form-group>

    <sudo-modal
      v-if="showSudoModal"
      @success="changePassword"
      @close="showSudoModal = false"
    ></sudo-modal>
  </ly-form>
</template>

<script>
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  import SudoModal from 'src/components/general/SudoModal'

  export default {
    mixins: [ErrorsHandler],

    components: {
      SudoModal,
    },

    data () {
      return {
        password: '',
        showSudoModal: false,
      }
    },

    methods: {
      changePassword () {
        this.$store
          .dispatch('users/changePassword', {
            password: this.password,
          })
          .then(() => {
            this.$emit('success')
            this.password = ''
            this.showSudoModal = false
          })
          .catch((e) => {
            this.showSudoModal = e.data.errors.some(error => error.code === 'unauthorized')
          })
      },
    },
  }
</script>
