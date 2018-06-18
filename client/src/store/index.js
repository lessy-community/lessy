import Vue from 'vue'
import Vuex from 'vuex'

import global from './modules/global'
import users from './modules/users'
import projects from './modules/projects'
import tasks from './modules/tasks'

import cablePlugin from './plugins/cable'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    global,
    users,
    projects,
    tasks,
  },
  plugins: [
    cablePlugin,
  ],
  strict: debug,
})
