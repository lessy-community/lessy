import Vue from 'vue'
import VueI18n from 'vue-i18n'

import en from './en'
import fr from './fr'

Vue.use(VueI18n)

export const SUPPORTED_LANGUAGES = ['en', 'fr']

const i18n = new VueI18n({
  locale: getPreferedLanguage(),
  fallbackLocale: 'en',
  messages: {
    en: en.messages,
    fr: fr.messages,
  },
  dateTimeFormats: {
    en: en.dateTimeFormats,
    fr: fr.dateTimeFormats,
  },
})

export function getPreferedLanguage () {
  const localStorageLanguage = window.localStorage.getItem('language')
  if (SUPPORTED_LANGUAGES.includes(localStorageLanguage)) {
    return localStorageLanguage
  }
  const browserLanguage = window.navigator.language
  if (SUPPORTED_LANGUAGES.includes(browserLanguage)) {
    return browserLanguage
  }
  return 'en'
}

export function savePreferedLanguage (language) {
  if (SUPPORTED_LANGUAGES.includes(language)) {
    window.localStorage.setItem('language', language)
    i18n.locale = language
    return language
  }
}

export default i18n
