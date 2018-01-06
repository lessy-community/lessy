# Syncing notifications (websocket)

A websocket endpoint is accessible at `wss://lessy.io/cable`. This websocket
notifies subscribers of any change on tasks and projects.

Please note this is an experimental feature so it might be unstable.

Current implementation is accessible under `client/src/store/plugins/cable.js`.

## Authentication

Websocket notifications are per user and must be authenticated. Once user is
logged in, just set a `Authorization` session cookie that will be sent at the
websocket connection:

```js
document.cookie = 'Authorization=<user token>;path=/'
```

The token is the same than the one used during [API authentication](authentication.md).

## Subscription

Since the notification system is based on [Rails ActionCable feature](http://guides.rubyonrails.org/action_cable_overview.html),
we use [actioncable package](https://www.npmjs.com/package/actioncable) to
help us to handle the connection.

Once you set the authentication cookie, you only have to create a websocket
consumer and to subscribe to `NotificationsChannel`:

```js
import ActionCable from 'actioncable'

const cable = ActionCable.createConsumer()
cable.subscriptions.create(
  { channel: 'NotificationsChannel' },
  {
    received: function (data) {
      // do something
    },
  }
)
```

## Notification format

The notification format is very simple. It consists in a Json object with few
attributes.

`action` represents an action that happened on the server and always follows
this format: `actionType#resourceType` where:

- `actionType` can either be `create` (a new resource has been created on the
  server) or `update` (a resource has been updated)
- `resourceType` can either be `projects` or `tasks`

`id` attribute indicates the concerned resource's `id`.

`updatedAt` attribute is only sent on `update` actions and indicates the
timestamp of the last resource update.

For instance, the following notification represents the creation of project
`42`:

```json
{
  "action": "create#projects",
  "id": 42
}
```

And this notification represents an modification of task `23`:

```json
{
  "action": "update#tasks",
  "id": 23,
  "updatedAt": 1515248100
}
```

When you receive such a notification, you know that you can refresh your
application state unless you already have the concerned resource up-to-date.

**Important note**: there is no notifications yet on task's order changes since
it can concern a lot of different tasks and it can be cumbersome to fetch all
the concerned tasks.
