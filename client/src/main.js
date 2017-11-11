import Vue from 'vue'

import { Popover, PopoverItem } from './components/Popover'

import DateField from './components/fields/DateField'
import EmailField from './components/fields/EmailField'
import FormGroup from './components/fields/FormGroup'
import PasswordField from './components/fields/PasswordField'
import StaticField from './components/fields/StaticField'
import TextField from './components/fields/TextField'

import LyBadge from './components/Ly/LyBadge'
import LyButton from './components/Ly/LyButton'
import LyCard from './components/Ly/LyCard'
import LyCardDeck from './components/Ly/LyCardDeck'
import { LyColumns, LyColumn } from './components/Ly/LyColumns'
import LyIcon from './components/Ly/LyIcon'
import { LyList, LyListItem, LyListItemAdapt } from './components/Ly/LyList'
import LyTextContainer from './components/Ly/LyTextContainer'

import App from './components/App/App'
import AppHeader from './components/App/AppHeader'
import AppHeaderLink from './components/App/AppHeaderLink'
import AppLayout from './components/App/AppLayout'
import AppPage from './components/App/AppPage'
import AppMenu from './components/App/AppMenu'
import AppMenuLink from './components/App/AppMenuLink'

import i18n from './locales'
import router from './router'
import store from './store'

import Tooltip from 'vue-directive-tooltip'

Vue.use(Tooltip)

// register global components
Vue.component('popover', Popover)
Vue.component('popover-item', PopoverItem)

Vue.component('date-field', DateField)
Vue.component('email-field', EmailField)
Vue.component('form-group', FormGroup)
Vue.component('password-field', PasswordField)
Vue.component('static-field', StaticField)
Vue.component('text-field', TextField)

Vue.component('app-header', AppHeader)
Vue.component('app-header-link', AppHeaderLink)
Vue.component('app-layout', AppLayout)
Vue.component('app-page', AppPage)
Vue.component('app-menu', AppMenu)
Vue.component('app-menu-link', AppMenuLink)

Vue.component('ly-badge', LyBadge)
Vue.component('ly-button', LyButton)
Vue.component('ly-card', LyCard)
Vue.component('ly-card-deck', LyCardDeck)
Vue.component('ly-columns', LyColumns)
Vue.component('ly-column', LyColumn)
Vue.component('ly-icon', LyIcon)
Vue.component('ly-list', LyList)
Vue.component('ly-list-item', LyListItem)
Vue.component('ly-list-item-adapt', LyListItemAdapt)
Vue.component('ly-text-container', LyTextContainer)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
  i18n,
})
