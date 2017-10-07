# Authentication (API)

Almost all API requests require authentication which is based on a JsonWebToken
system. We will discuss how to get user token later in this document.

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
