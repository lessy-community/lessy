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
      <ly-button submit>
        {{ $t('profile.passwordNewForm.submit') }}
      </ly-button>
      <span :class="['text-success', { show: saved }]">
        <ly-icon name="check"></ly-icon>
        {{ $t('profile.passwordNewForm.saved') }}
      </span>
    </ly-form-group>

    <sudo-modal
      v-if="showSudoModal"
      @success="changePassword"
      @close="showSudoModal = false"
    ></sudo-modal>
  </ly-form>
</template>

<script>
  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  import SudoModal from '@/components/general/SudoModal'

  export default {
    mixins: [ErrorsHandler],

    components: {
      SudoModal,
    },

    data () {
      return {
        password: '',
        showSudoModal: false,
        saved: false,
      }
    },

    methods: {
      changePassword () {
        this.$store
          .dispatch('users/changePassword', {
            password: this.password,
          })
          .then(() => {
            this.password = ''
            this.showSudoModal = false
            this.saved = true
            setTimeout(() => { this.saved = false }, 5000)
          })
          .catch((e) => {
            this.showSudoModal = e.data.errors.some(error => error.code === 'unauthorized')
          })
      },
    },
  }
</script>

<style lang="scss" scoped>
  .text-success {
    opacity: 0;

    transition: opacity .2s ease-in-out;

    &.show {
      opacity: 1;
    }
  }
</style>
