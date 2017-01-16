import Vue from 'vue'
import VueRouter from 'vue-router'

import ActivateUserPage from './components/pages/ActivateUser'
import DashboardPage from './components/pages/Dashboard'
import HomePage from './components/pages/Home'
import LoginPage from './components/pages/Login'
import NotFoundPage from './components/pages/NotFound'

import ProjectLayout from './components/layout/Project'
import ProjectShowPage from './components/pages/projects/Show'
import ProjectEditPage from './components/pages/projects/Edit'
import ProjectStartPage from './components/pages/projects/Start'
import ProjectFinishPage from './components/pages/projects/Finish'

import auth from './auth'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: HomePage, meta: { restrictForUnauth: true } },
  { path: '/login', component: LoginPage, meta: { restrictForUnauth: true } },
  { path: '/users/:token/activate', component: ActivateUserPage },
  { path: '/dashboard', component: DashboardPage, meta: { restrictForAuth: true } },
  { path: '/:userIdentifier/:projectName',
    component: ProjectLayout,
    children: [
      { path: '', component: ProjectShowPage, name: 'project/show' },
      { path: 'edit', component: ProjectEditPage, name: 'project/edit' },
      { path: 'start', component: ProjectStartPage, name: 'project/start' },
      { path: 'finish', component: ProjectFinishPage, name: 'project/finish' },
    ]
  },
  { path: '*', component: NotFoundPage },
]

let router = new VueRouter({
  mode: 'history',
  routes,
})

function isRestrictedForAuth (route) {
  return route.matched.some(record => record.meta.restrictForAuth)
}

function isRestrictedForUnauth (route) {
  return route.matched.some(record => record.meta.restrictForUnauth)
}

router.beforeEach((to, from, next) => {
  if (isRestrictedForAuth(to) && !auth.isLoggedIn()) {
    next({ path: '/' })
  } else if (isRestrictedForUnauth(to) && auth.isLoggedIn()) {
    next({ path: '/dashboard' })
  } else {
    next()
  }
})

export default router
export {
  isRestrictedForAuth,
  isRestrictedForUnauth,
}
