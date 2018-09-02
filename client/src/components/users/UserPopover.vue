<template>
  <ly-popover v-if="user">
    <ly-button
      slot="toggle"
      type="ghost"
      icon="user"
    >
      {{ user.displayedName }}
    </ly-button>

    <template slot="menu">
      <ly-popover-item to="/profile">
        {{ $t('users.popover.profile') }}
      </ly-popover-item>

      <ly-popover-separator></ly-popover-separator>

      <ly-popover-item v-if="user.admin" :href="adminUrl">
        {{ $t('users.popover.administration') }}
        <ly-icon name="user-secret" class="float-right"></ly-icon>
      </ly-popover-item>

      <ly-popover-item @click="logout">
        {{ $t('users.popover.logout') }}
        <ly-icon name="sign-out" class="float-right"></ly-icon>
      </ly-popover-item>
    </template>
  </ly-popover>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        user: 'users/current',
      }),

      adminUrl () {
        if (process.env.NODE_ENV === 'development') {
          return 'http://localhost:3000/admin'
        } else {
          return '/admin'
        }
      },
    },

    methods: {
      logout () {
        this.$store.dispatch('users/logout')
        window.location = '/'
      },
    },
  }
</script>

<style scoped>
  .ly-icon.float-right {
    float: right;
  }
</style>
