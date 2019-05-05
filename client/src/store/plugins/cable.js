import ActionCable from 'actioncable'
import auth from '@/auth'

function cablePlugin (store) {
  if (!auth.isLoggedIn()) {
    return
  }

  document.cookie = `Authorization=${auth.getToken()};path=/`
  const cable = ActionCable.createConsumer()
  cable.subscriptions.create(
    { channel: 'NotificationsChannel' },
    {
      received: data => {
        const [actionType, resourceType] = data.action.split('#', 2)
        if (actionType === 'create') {
          const resource = store.getters[`${resourceType}/findById`](data.id)
          if (!resource) {
            store.dispatch(`${resourceType}/get`, { id: data.id })
          }
        } else if (actionType === 'update') {
          const resource = store.getters[`${resourceType}/findById`](data.id)
          if (!resource || resource.updatedAt < data.updatedAt) {
            store.dispatch(`${resourceType}/get`, { id: data.id })
          }
        }
      },
    }
  )
}

export default cablePlugin
