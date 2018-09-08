<template>
  <div class="profile-delete-account">
    <ly-form @submit="deleteAccount">
      <ly-card>
        <p class="text-warning" v-html="$t('profile.deleteAccount.warn')">
        </p>
      </ly-card>

      <ly-form-group>
        <ly-form-input
          type="text"
          name="understand"
          v-model="understand"
          :label="$t('profile.deleteAccount.understandLabel')"
          required
        ></ly-form-input>
      </ly-form-group>

      <ly-button
        :disabled="understand !== $t('profile.deleteAccount.understand')"
        submit
      >
        {{ $t('profile.deleteAccount.submit') }}
      </ly-button>
    </ly-form>

    <sudo-modal
      v-if="showSudoModal"
      @success="deleteAccount"
      @close="showSudoModal = false"
    ></sudo-modal>
  </div>
</template>

<script>
  import auth from 'src/auth'

  import SudoModal from 'src/components/general/SudoModal'

  export default {
    components: {
      SudoModal,
    },

    data () {
      return {
        showSudoModal: false,
        understand: '',
      }
    },

    methods: {
      deleteAccount () {
        this.$store
          .dispatch('users/deleteAccount')
          .then(() => {
            auth.logout()
            window.location = '/'
          })
          .catch((e) => {
            this.showSudoModal = e.data.errors.some(error => error.code === 'unauthorized')
          })
      },
    },
  }
</script>
