<template>
  <ly-form>
    <ly-form-group>
      <ly-form-select
        name="timeZone"
        :value="timeZone"
        :options="options"
        :caption="$t('profile.timeZoneForm.timeZoneCaption')"
        :label="$t('profile.timeZoneForm.timeZoneLabel')"
        :placeholder="$t('profile.timeZoneForm.timeZonePlaceholder')"
        required
        @input="changeTimeZone"
      ></ly-form-select>
    </ly-form-group>

    <ly-card v-if="guessedTimeZoneIsDifferent" class="card-autodetect">
      <p class="text-warning">
        {{ $t('profile.timeZoneForm.autodetectInfo') }}
      </p>
      <ly-button @click="autodetect" type="primary">
        {{ $t('profile.timeZoneForm.autodetect') }}
      </ly-button>
    </ly-card>

    <span :class="['text-success', { show: saved }]">
      <ly-icon name="check"></ly-icon>
      {{ $t('profile.timeZoneForm.saved') }}
    </span>
  </ly-form>
</template>

<script>
  import moment from 'moment-timezone'

  import ErrorsHandler from '@/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      user: { type: Object, required: true },
    },

    data () {
      return {
        timeZone: this.user.timeZone,
        options: moment.tz.names().map((timeZone) => {
          return {
            value: timeZone,
            label: timeZone,
          }
        }),
        saved: false,
      }
    },

    computed: {
      guessedTimeZoneIsDifferent () {
        const guessedTimeZone = moment.tz.guess()
        return guessedTimeZone !== this.user.timeZone
      }
    },

    methods: {
      changeTimeZone (value) {
        this.timeZone = value
        if (value == null) {
          return
        }

        this.cleanErrors()
        this.$store
          .dispatch('users/updateCurrent', {
            timeZone: this.timeZone,
          })
          .then(() => {
            this.saved = true
            setTimeout(() => { this.saved = false }, 5000)
          })
          .catch(this.setFailureErrors)
      },

      autodetect () {
        if (this.guessedTimeZoneIsDifferent) {
          const guessedTimeZone = moment.tz.guess()
          this.changeTimeZone(guessedTimeZone)
        }
      },
    },
  }
</script>

<style lang="scss" scoped>
  .card-autodetect {
    text-align: center;

    p {
      text-align: left;
    }
  }

  .text-success {
    opacity: 0;

    transition: opacity .2s ease-in-out;

    &.show {
      opacity: 1;
    }
  }
</style>
