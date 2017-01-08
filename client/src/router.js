import Vue from 'vue'
import VueRouter from 'vue-router'

import ActivateUserPage from './pages/ActivateUser'
import DashboardPage from './pages/Dashboard'
import HomePage from './pages/Home'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: HomePage, meta: { forbidForAuth: true } },
  { path: '/users/:token/activate', component: ActivateUserPage },
  { path: '/dashboard', component: DashboardPage, meta: { requiresAuth: true } },
]

let router = new VueRouter({
  mode: 'history',
  routes,
})

function haveAuthAccess (to) {
  const token = window.localStorage.getItem('authentication_token')
  const requiresAuth = to.matched.some(record => record.meta.requiresAuth)
  return !requiresAuth || token != null
}

function authHaveAccess (to) {
  const token = window.localStorage.getItem('authentication_token')
  const forbidForAuth = to.matched.some(record => record.meta.forbidForAuth)
  return token == null || !forbidForAuth
}

router.beforeEach((to, from, next) => {
  if (!haveAuthAccess(to)) {
    next({ path: '/' })
  } else if (!authHaveAccess(to)) {
    next({ path: '/dashboard' })
  } else {
    next()
  }
})

export default router
