import Vue from 'vue'

import App from './components/layout/App'

import Btn from './components/Btn'
import Card from './components/Card'
import Container from './components/Container'
import ListItem from './components/ListItem'

import DateField from './components/fields/DateField'
import EmailField from './components/fields/EmailField'
import FormGroup from './components/fields/FormGroup'
import PasswordField from './components/fields/PasswordField'
import StaticField from './components/fields/StaticField'
import TextField from './components/fields/TextField'

import router from './router'
import store from './store'

// register global components
Vue.component('btn', Btn)
Vue.component('card', Card)
Vue.component('container', Container)
Vue.component('list-item', ListItem)

Vue.component('date-field', DateField)
Vue.component('email-field', EmailField)
Vue.component('form-group', FormGroup)
Vue.component('password-field', PasswordField)
Vue.component('static-field', StaticField)
Vue.component('text-field', TextField)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
})
