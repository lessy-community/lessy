import Vue from 'vue'

import App from './components/layout/App'

import router from './router'
import store from './store'

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
})
