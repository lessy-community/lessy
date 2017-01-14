import Vue from 'vue'

import App from './components/layout/App'

import Btn from './components/Btn'
import Container from './components/Container'
import PasswordField from './components/PasswordField'

import router from './router'
import store from './store'

// register global components
Vue.component('btn', Btn)
Vue.component('container', Container)
Vue.component('password-field', PasswordField)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
})
