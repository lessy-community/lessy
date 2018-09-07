import { get } from './http'

export default {
  getCurrent () {
    return get('/api/terms_of_services/current', { authorization: 'none' })
  },
}
