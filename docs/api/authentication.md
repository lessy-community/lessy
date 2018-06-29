# Authentication (API)

Almost all API requests require authentication which is based on a JsonWebToken
system. We will discuss how to get user token later in this document.

Important note: unless it is specified, the endpoints requiring authentication
also require that user accepted current terms of service.

To authenticate through Lessy API, you have to send an `Authentication` HTTP
header.

Example:

```console
$ curl -H 'Authorization: <token>' https://lessy.io/api/users/me
```

Or in JavaScript:

```js
window.fetch('https://lessy.io/api/users/me', {
  method: 'GET',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': '<token>',
  },
});
```

To obtain a token you must authorize yourself:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"username": "dalecooper", "password": "secret"}' \
       https://lessy.io/api/users/authorizations
```

If everything is OK, it should return:

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "username": "dalecooper",
      "email": "dale.cooper@lessy.io"
    }
  },
  "meta": {
    "token": "<token>"
  }
}
```

The returned token must be saved and is valid for the next month only. Then it
will be invalidated.

You can learn more about `users` API in [the dedicated section](users.md).
