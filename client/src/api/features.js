import { get } from './http'

export default {
  list () {
    return get('/api/users/me/features')
  },
}
