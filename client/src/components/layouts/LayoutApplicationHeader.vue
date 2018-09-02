<template>
  <app-header :title="title" fluid>
    <slot v-if="$slots.default" slot="navigation"></slot>
    <template slot="right">
      {{ user.displayedName }}
      <ly-button type="ghost" @click="logout">{{ $t('app.appHeader.logout') }}</ly-button>
    </template>
  </app-header>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: {
      title: { type: String, required: true },
    },

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
