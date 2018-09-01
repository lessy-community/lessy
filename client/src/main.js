import Vue from 'vue'

import LyBadge from './components/Ly/LyBadge'
import LyButton from './components/Ly/LyButton'
import LyCard from './components/Ly/LyCard'
import LyCardDeck from './components/Ly/LyCardDeck'
import { LyColumns, LyColumn } from './components/Ly/LyColumns'
import { LyForm, LyFormGroup, LyFormInput, LyFormSelect, LyFormTextarea } from './components/Ly/LyForm'
import LyIcon from './components/Ly/LyIcon'
import { LyList, LyListGroup, LyListItem, LyListItemAdapt } from './components/Ly/LyList'
import LyModal from './components/Ly/LyModal'
import { LyPopover, LyPopoverItem, LyPopoverSeparator } from './components/Ly/LyPopover'
import LySection from './components/Ly/LySection'
import LyTextContainer from './components/Ly/LyTextContainer'

import App from './components/App/App'
import AppHeader from './components/App/AppHeader'
import AppHeaderLink from './components/App/AppHeaderLink'
import AppLayout from './components/App/AppLayout'
import AppPage from './components/App/AppPage'
import AppMenu from './components/App/AppMenu'
import AppMenuLink from './components/App/AppMenuLink'

import LayoutApplication from './components/layouts/LayoutApplication'
import LayoutDefault from './components/layouts/LayoutDefault'
import LayoutDesign from './components/layouts/LayoutDesign'
import LayoutEmpty from './components/layouts/LayoutEmpty'
import LayoutSingleForm from './components/layouts/LayoutSingleForm'

import LoadingPage from './components/general/LoadingPage'

import i18n from './locales'
import router from './router'
import store from './store'

import VTooltip from 'v-tooltip'

Vue.use(VTooltip)

// register global components
Vue.component('app-header', AppHeader)
Vue.component('app-header-link', AppHeaderLink)
Vue.component('app-layout', AppLayout)
Vue.component('app-page', AppPage)
Vue.component('app-menu', AppMenu)
Vue.component('app-menu-link', AppMenuLink)

Vue.component('layout-application', LayoutApplication)
Vue.component('layout-default', LayoutDefault)
Vue.component('layout-design', LayoutDesign)
Vue.component('layout-empty', LayoutEmpty)
Vue.component('layout-single-form', LayoutSingleForm)

Vue.component('loading-page', LoadingPage)

Vue.component('ly-badge', LyBadge)
Vue.component('ly-button', LyButton)
Vue.component('ly-card', LyCard)
Vue.component('ly-card-deck', LyCardDeck)
Vue.component('ly-columns', LyColumns)
Vue.component('ly-column', LyColumn)
Vue.component('ly-form', LyForm)
Vue.component('ly-form-group', LyFormGroup)
Vue.component('ly-form-input', LyFormInput)
Vue.component('ly-form-select', LyFormSelect)
Vue.component('ly-form-textarea', LyFormTextarea)
Vue.component('ly-icon', LyIcon)
Vue.component('ly-list', LyList)
Vue.component('ly-list-group', LyListGroup)
Vue.component('ly-list-item', LyListItem)
Vue.component('ly-list-item-adapt', LyListItemAdapt)
Vue.component('ly-modal', LyModal)
Vue.component('ly-popover', LyPopover)
Vue.component('ly-popover-item', LyPopoverItem)
Vue.component('ly-popover-separator', LyPopoverSeparator)
Vue.component('ly-section', LySection)
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
