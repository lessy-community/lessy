import Vue from 'vue'

import App from './components/layout/App'

import Btn from './components/Btn'
import Container from './components/Container'
import EmailField from './components/EmailField'
import FormGroup from './components/FormGroup'
import ListItem from './components/ListItem'
import PasswordField from './components/PasswordField'
import TextField from './components/TextField'

import router from './router'
import store from './store'

// register global components
Vue.component('btn', Btn)
Vue.component('container', Container)
Vue.component('email-field', EmailField)
Vue.component('form-group', FormGroup)
Vue.component('list-item', ListItem)
Vue.component('password-field', PasswordField)
Vue.component('text-field', TextField)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
})
