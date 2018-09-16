<template>
  <app-page name="loading" layout="empty" centered>
    <h1>{{ $t('general.loadingPage.title') }}</h1>

    <ly-icon name="circle-o-notch" size="large" spin></ly-icon>

    <p v-if="!showReset" class="waiter text-secondary">
      {{ $t('general.loadingPage.wait') }}
    </p>
    <div v-else class="reset-block">
      <p class="text-secondary">
        {{ $t('general.loadingPage.tooLong') }}
      </p>
      <ly-button @click="reset">
        {{ $t('general.loadingPage.reset') }}
      </ly-button>
    </div>
  </app-page>
</template>

<script>
  import auth from 'src/auth'

  export default {
    data () {
      return {
        showReset: false,
      }
    },

    methods: {
      reset () {
        auth.logout()
        window.location = '/login'
      },
    },

    mounted () {
      setTimeout(() => { this.showReset = true }, 10000)
    },
  }
</script>

<style lang="scss">
  .app-page-loading .app-layout-main {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);

    > .waiter,
    > .reset-block {
      margin-top: 1.5rem;
    }

    .reset-block {
      max-width: 30rem;

      text-align: center;
    }
  }
</style>
