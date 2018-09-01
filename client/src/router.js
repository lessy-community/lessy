import Vue from 'vue'
import VueRouter from 'vue-router'

import HomeLayout from './components/general/HomeLayout'
import NotFoundLayout from './components/general/NotFoundLayout'
import TermsOfServiceLayout from './components/general/TermsOfServiceLayout'

import UserActivateLayout from './components/users/UserActivateLayout'
import UserLoginLayout from './components/users/UserLoginLayout'
import UserPasswordResetLayout from './components/users/UserPasswordResetLayout'
import UserPasswordNewLayout from './components/users/UserPasswordNewLayout'

import DashboardLayout from './components/dashboard/DashboardLayout'

import ProjectsLayout from './components/projects/ProjectsLayout'
import ProjectsInboxPage from './components/projects/ProjectsInboxPage'
import ProjectLayout from './components/projects/ProjectLayout'
import ProjectShowPage from './components/projects/ProjectShowPage'
import ProjectEditPage from './components/projects/ProjectEditPage'

import TasksLayout from './components/tasks/TasksLayout'
import TasksBacklogPage from './components/tasks/TasksBacklogPage'
import TasksStatisticsPage from './components/tasks/TasksStatisticsPage'

import DesignIndexPage from './components/design/DesignIndexPage'
import DesignGridPage from './components/design/DesignGridPage'
import DesignTypographyPage from './components/design/DesignTypographyPage'
import DesignColorsPage from './components/design/DesignColorsPage'
import DesignVisualsPage from './components/design/DesignVisualsPage'
import DesignComponentsPage from './components/design/DesignComponentsPage'
import DesignWordingPage from './components/design/DesignWordingPage'

import auth from './auth'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: HomeLayout, meta: { restrictForUnauth: true, title: 'Welcome' } },
  { path: '/login', component: UserLoginLayout, meta: { restrictForUnauth: true, title: 'Login' } },
  { path: '/password/reset', component: UserPasswordResetLayout, meta: { restrictForUnauth: true, title: 'Reset your password' } },
  { path: '/password/:token/new', component: UserPasswordNewLayout, meta: { restrictForUnauth: true, title: 'Change your password' } },
  { path: '/terms-of-service', component: TermsOfServiceLayout, meta: { title: 'Terms of service' } },
  { path: '/users/:token/activate', component: UserActivateLayout, meta: { title: 'User activation' } },
  { path: '/dashboard', component: DashboardLayout, meta: { restrictForAuth: true, title: 'Dashboard' } },
  { path: '/tasks',
    component: TasksLayout,
    children: [
      { path: '', redirect: 'backlog' },
      { path: 'backlog', component: TasksBacklogPage, name: 'tasks/backlog', meta: { title: 'Backlog' } },
      { path: 'statistics', component: TasksStatisticsPage, name: 'tasks/statistics', meta: { title: 'Statistics' } },
    ],
    meta: { restrictForAuth: true },
  },
  { path: '/projects',
    component: ProjectsLayout,
    children: [
      { path: '', redirect: 'inbox' },
      { path: 'inbox', component: ProjectsInboxPage, meta: { title: 'Inbox' } },
      { path: ':projectSlug',
        component: ProjectLayout,
        children: [
          { path: '', component: ProjectShowPage, name: 'project/show', meta: { title: 'Project' } },
          { path: 'edit', component: ProjectEditPage, name: 'project/edit', meta: { title: 'Project' } },
        ],
        props: true,
      },
    ],
    meta: { restrictForAuth: true },
  },
  { path: '/design', component: DesignIndexPage, meta: { title: 'Lessy Design Guide' } },
  { path: '/design/grid', component: DesignGridPage, meta: { title: 'Grid · Lessy Design Guide' } },
  { path: '/design/typography', component: DesignTypographyPage, meta: { title: 'Typography · Lessy Design Guide' } },
  { path: '/design/colors', component: DesignColorsPage, meta: { title: 'Colors · Lessy Design Guide' } },
  { path: '/design/visuals', component: DesignVisualsPage, meta: { title: 'Visuals · Lessy Design Guide' } },
  { path: '/design/components', component: DesignComponentsPage, meta: { title: 'Components · Lessy Design Guide' } },
  { path: '/design/wording', component: DesignWordingPage, meta: { title: 'Wording · Lessy Design Guide' } },
  { path: '*', component: NotFoundLayout },
]

let router = new VueRouter({
  mode: 'history',
  routes,
  scrollBehavior (to, from, savedPosition) {
    return { x: 0, y: 0 }
  }
})

function isRestrictedForAuth (route) {
  return route.matched.some(record => record.meta.restrictForAuth)
}

function isRestrictedForUnauth (route) {
  return route.matched.some(record => record.meta.restrictForUnauth)
}

router.beforeEach((to, from, next) => {
  document.title = to.meta.title ? to.meta.title + ' · Lessy' : 'Lessy'
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
