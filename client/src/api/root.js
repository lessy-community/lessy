import { get } from './http'

export default {
  listInfo () {
    return get('/api')
  },
}
