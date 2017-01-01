<template>
  <div v-if="error" class="error-page">
    {{ error }}
  </div>
  <div v-else-if="!user" class="loading-page">
    Chargement en cours…
  </div>
  <div v-else class="dashboard-page">
    Hello, {{ user.username || user.email }}!
    <p v-if="!user.username">
      We sent you an email at {{ user.email }}.<br />
      Follow its instructions to be able to access your projects later.
    </p>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  name: 'dashboard-page',
  data () {
    return {
      error: null,
    }
  },
  computed: {
    ...mapState({
      user: (state) => state.users.current,
    }),
  },
  mounted () {
    this.$store
      .dispatch('users/getCurrent')
      .catch((error) => {
        this.error = error.data.message
      })
  },
}
</script>
