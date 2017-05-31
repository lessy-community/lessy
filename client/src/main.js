import Vue from 'vue'

import App from './components/layout/App'

import Badge from './components/Badge'
import Btn from './components/Btn'
import Card from './components/Card'
import Container from './components/Container'
import Icon from './components/Icon'
import ListItem from './components/ListItem'
import { Popover, PopoverItem } from './components/Popover'
import Tabs from './components/Tabs'

import DateField from './components/fields/DateField'
import EmailField from './components/fields/EmailField'
import FormGroup from './components/fields/FormGroup'
import PasswordField from './components/fields/PasswordField'
import StaticField from './components/fields/StaticField'
import TextField from './components/fields/TextField'

import AppContent from './components/layout/AppContent'

import i18n from './locales'
import router from './router'
import store from './store'

import Tooltip from 'vue-directive-tooltip'

Vue.use(Tooltip)

// register global components
Vue.component('badge', Badge)
Vue.component('btn', Btn)
Vue.component('card', Card)
Vue.component('container', Container)
Vue.component('icon', Icon)
Vue.component('list-item', ListItem)
Vue.component('popover', Popover)
Vue.component('popover-item', PopoverItem)
Vue.component('tabs', Tabs)

Vue.component('date-field', DateField)
Vue.component('email-field', EmailField)
Vue.component('form-group', FormGroup)
Vue.component('password-field', PasswordField)
Vue.component('static-field', StaticField)
Vue.component('text-field', TextField)

Vue.component('app-content', AppContent)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
  i18n,
})
