<template>
  <div class="dashboard-page">
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
  computed: {
    ...mapState({
      user: (state) => state.users.current,
    }),
  },
}
</script>
