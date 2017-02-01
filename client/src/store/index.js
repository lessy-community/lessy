import Vue from 'vue'
import Vuex from 'vuex'

import users from './modules/users'
import projects from './modules/projects'
import tasks from './modules/tasks'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    users,
    projects,
    tasks,
  },
  strict: debug,
})
