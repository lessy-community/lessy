<template>
  <div v-if="user" class="user-popover">
    {{ user.displayedName }}
    <ly-button type="ghost" @click="logout">
      {{ $t('users.popover.logout') }}
    </ly-button>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        user: 'users/current',
      }),
    },

    methods: {
      logout () {
        this.$store.dispatch('users/logout')
        window.location = '/'
      },
    },
  }
</script>
