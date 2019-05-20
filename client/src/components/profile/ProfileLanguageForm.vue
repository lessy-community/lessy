<template>
  <ly-form :size="light ? 'small' : 'normal'">
    <ly-form-group>
      <ly-form-select
        name="language"
        icon="language"
        :value="language"
        :options="options"
        :label="light ? null : $t('profile.languageForm.languageLabel')"
        required
        @input="changeLanguage"
      ></ly-form-select>
    </ly-form-group>

    <span v-if="!light" :class="['text-success', { show: saved }]">
      <ly-icon name="check"></ly-icon>
      {{ $t('profile.languageForm.saved') }}
    </span>
  </ly-form>
</template>

<script>
  import {
    SUPPORTED_LANGUAGES,
    getPreferedLanguage,
    savePreferedLanguage,
  } from '@/locales'

  export default {
    props: {
      light: { type: Boolean },
    },

    data () {
      return {
        language: getPreferedLanguage(),
        options: SUPPORTED_LANGUAGES.map((language) => {
          return {
            value: language,
            label: this.$t(`languages.${language}`),
          }
        }),
        saved: false,
      }
    },

    methods: {
      changeLanguage (value) {
        this.language = value
        const savedLanguage = savePreferedLanguage(this.language)
        if (savedLanguage === this.language) {
          this.saved = true
          setTimeout(() => { this.saved = false }, 5000)
        }
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
