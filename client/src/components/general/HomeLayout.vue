<template>
  <app-layout name="home">
    <welcome-header slot="header"></welcome-header>
    <app-page name="home">
      <ly-columns name="home-top">
        <ly-column>
          <div class="app-page-home-intro">
            <h1>{{ $t('general.homeLayout.title') }}</h1>
            <p class="text-secondary">{{ $t('general.homeLayout.intro') }}</p>
          </div>

          <ly-card v-if="infoReady">
            <div v-if="registrationDisabled" class="app-page-home-registration-disabled">
              <p>
                <ly-icon name="frown-o" size="large"></ly-icon><br />
                <span v-html="$t('general.homeLayout.registrationDisabled')"></span>
              </p>
              <router-link to="/login">
                {{ $t('general.homeLayout.login') }}
              </router-link>
            </div>
            <user-register-form v-else :on-success="onRegistrationSuccess"></user-register-form>
          </ly-card>
        </ly-column>

        <ly-column>
          <a href="/static/back-home.png" target="_blank" rel="noreferrer">
            <img src="/static/back-home.png" alt="" />
          </a>
        </ly-column>
      </ly-columns>

      <h2>{{ $t('general.homeLayout.detailsTitle') }}</h2>
      <ly-columns name="home-details">
        <ly-column>
          <ly-icon name="diamond" size="large"></ly-icon>
          <h3>{{ $t('general.homeLayout.timeTitle') }}</h3>
          <p v-html="$t('general.homeLayout.timeDetails')"></p>
        </ly-column>

        <ly-column>
          <ly-icon name="hand-peace-o" size="large"></ly-icon>
          <h3>{{ $t('general.homeLayout.lessTitle') }}</h3>
          <p v-html="$t('general.homeLayout.lessDetails')"></p>
        </ly-column>

        <ly-column>
          <ly-icon name="handshake-o" size="large"></ly-icon>
          <h3>{{ $t('general.homeLayout.communityTitle') }}</h3>
          <p v-html="$t('general.homeLayout.communityDetails')"></p>
        </ly-column>
      </ly-columns>

      <ly-card name="home-more">
        <h2>{{ $t('general.homeLayout.moreTitle') }}</h2>
        <ly-columns>
          <ly-column>
            <h3>
              <ly-icon name="git"></ly-icon>
              <a href="https://github.com/lessy-community/lessy">
                {{ $t('general.homeLayout.exploreTitle') }}
              </a>
            </h3>
            <p class="text-secondary"><small v-html="$t('general.homeLayout.exploreDetails')"></small></p>
          </ly-column>

          <ly-column>
            <h3>
              <ly-icon name="globe"></ly-icon>
              <a href="https://github.com/lessy-community/lessy/blob/master/docs/production_environment.md">
                {{ $t('general.homeLayout.hostTitle') }}
              </a>
            </h3>
            <p class="text-secondary"><small v-html="$t('general.homeLayout.hostDetails')"></small></p>
          </ly-column>

          <ly-column>
            <h3>
              <ly-icon name="eur"></ly-icon>
              <a href="https://liberapay.com/Lessy">
                {{ $t('general.homeLayout.donateTitle') }}
              </a>
            </h3>
            <p class="text-secondary"><small v-html="$t('general.homeLayout.donateDetails')"></small></p>
          </ly-column>
        </ly-columns>
      </ly-card>

      <footer>
        <p><small v-html="$t('general.homeLayout.madeWithLove')"></small></p>
        <p><small v-html="$t('general.homeLayout.greetings')"></small></p>
      </footer>
    </app-page>
  </app-layout>
</template>

<script>
  import { mapGetters } from 'vuex'

  import UserRegisterForm from 'src/components/users/UserRegisterForm'
  import WelcomeHeader from './WelcomeHeader'

  export default {
    components: {
      WelcomeHeader,
      UserRegisterForm,
    },

    data () {
      return {
        infoReady: false,
      }
    },

    computed: {
      ...mapGetters({
        registrationDisabled: 'global/registrationDisabled',
      }),
    },

    mounted () {
      this.$store
          .dispatch('global/listInfo')
          .then(() => {
            this.infoReady = true
          })
    },

    methods: {
      onRegistrationSuccess () {
        this.$router.push('/dashboard')
      },
    },
  }
</script>

<style lang="scss">
  .app-page-home {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);

    h1 {
      margin-bottom: .5rem;
    }
    h2 {
      text-align: center;
    }

    img {
      border-radius: .25rem;
      box-shadow: 0 0 1px $ly-color-grey-50,
                  1px 2px 3px $ly-color-grey-40;
    }

    .app-page-home-intro {
      max-width: 20rem;
      margin-bottom: 2rem;
    }

    .app-page-home-registration-disabled {
      text-align: center;
    }
    .app-page-home-registration-disabled p {
      margin-top: 1rem;
      margin-bottom: 2rem;
    }

    .ly-columns-home-top,
    .ly-columns-home-details {
      max-width: 80rem;
      margin-left: auto;
      margin-right: auto;
      margin-bottom: 6rem;
    }
    .ly-columns-home-top {
      margin-top: 2rem;

      .ly-column + .ly-column {
        flex-grow: 1.5;
      }
    }
    .ly-columns-home-details {
      .ly-column {
        text-align: center;
      }
      p {
        text-align: left;
      }
    }

    .ly-card-home-more {
      max-width: 50rem;
      margin-left: auto;
      margin-right: auto;
      margin-bottom: 6rem;

      .ly-card-body {
        padding-left: 2rem;
        padding-right: 2rem;
      }
    }

    footer {
      text-align: center;
    }
  }
  @media(max-width: $small-screen-width) {
    .app-page-home {
      .app-page-home-intro {
        max-width: none;
      }

      .ly-columns-home-top,
      .ly-columns-home-details,
      .ly-card-home-more {
        margin-bottom: 5rem;
      }
    }
  }
</style>
