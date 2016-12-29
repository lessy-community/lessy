// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import VueRouter from 'vue-router'

import ActivateUserPage from './pages/ActivateUser'
import DashboardPage from './pages/Dashboard'
import HomePage from './pages/Home'

import App from './App'

import store from './store'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: HomePage },
  { path: '/users/:token/activate', component: ActivateUserPage },
  { path: '/dashboard', component: DashboardPage },
]

const router = new VueRouter({
  mode: 'history',
  routes,
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  router,
  store,
})
