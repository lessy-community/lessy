import Vue from 'vue'
import VueI18n from 'vue-i18n'

import en from './en'

function init () {
  Vue.use(VueI18n)
  Vue.config.lang = 'en'
  Vue.locale('en', en)
}

export default {
  init,
}
