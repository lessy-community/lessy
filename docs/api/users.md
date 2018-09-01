# Users (API)

## `GET /api/users/me`

Return the user corresponding to the given token.

**This endpoint requires an `Authorization` header but NOT that user accepted
terms of service.**

Parameters: none.

Result format:

| Name                           | Type   | Description                                          | Optional |
|--------------------------------|--------|------------------------------------------------------|----------|
| data                           | object |                                                      |          |
| data.type                      | string | Type of returned data (always `user`)                |          |
| data.id                        | number | User's identifier                                    |          |
| data.attributes                | object |                                                      |          |
| data.attributes.username       | string | User's username                                      | yes      |
| data.attributes.email          | string | User's email                                         |          |
| data.attributes.admin          | bool   | Either if user is admin or not                       | yes      |
| data.attributes.hasAcceptedTos | bool   | Either if user has accepted current terms of service |          |

Note: `username` can be `null` if user's account has not been activated yet.

Example:

```console
$ curl -H "Authorization: <token>" https://lessy.io/api/users/me
```

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "username": "dalecooper",
      "email": "dale.cooper@lessy.io",
      "admin": false,
      "hasAcceptedTos": true
    }
  }
}
```

## `POST /api/users`

Create a new user on Lessy. This action sends an email to the given address
with a token required to activate the user.

**This endpoint doesn't require an `Authorization` header.**

Parameters:

| Name       | Type   | Description  | Optional |
|------------|--------|--------------|----------|
| user       | object |              |          |
| user.email | string | User's email |          |

Result format:

| Name                           | Type   | Description                                          | Optional |
|--------------------------------|--------|------------------------------------------------------|----------|
| data                           | object |                                                      |          |
| data.type                      | string | Type of returned data (always `user`)                |          |
| data.id                        | number | User's identifier                                    |          |
| data.attributes                | object |                                                      |          |
| data.attributes.email          | string | User's email                                         |          |
| data.attributes.admin          | bool   | Either if user is admin or not                       | yes      |
| data.attributes.hasAcceptedTos | bool   | Either if user has accepted current terms of service |          |
| meta                           | object |                                                      |          |
| meta.token                     | string | A temporary token (24 hours)                         |          |

Note: the returned token is only valid for 24 hours. To obtain full access, you
need to validate the user's account. Also, `hasAcceptedTos` should always be
`true` here unless an extremely rare race condition happens (i.e. new terms of
service are effective just after the creation of the user in DB).

Specific errors:

| Code                   | Description                                 |
|------------------------|---------------------------------------------|
| taken                  | Email address already exists                |
| registration\_disabled | Registration has been disabled by the admin |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"user": {"email": "dalecooper@lessy.io"}}' \
       https://lessy.io/api/users
```

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "username": null,
      "email": "dale.cooper@lessy.io",
      "admin": false,
      "hasAcceptedTos": true
    }
  },
  "meta": {
    "token": "<token>"
  }
}
```

## `POST /api/users/activations`

Activate an inactive user, using token from the activation email. It also sets
user's username and password.

**This endpoint doesn't require an `Authorization` header.**

Parameters:

| Name          | Type   | Description            | Optional |
|---------------|--------|------------------------|----------|
| user          | object |                        |          |
| user.username | string | User's username to set |          |
| user.password | string | User's password to set |          |
| token         | string | Activation token       |          |

**Important note:** the `token` is the one present in the link of the
**activation email** (e.g. `https://lessy.io/users/9xNZHo_YR1J8SvzseL_S/activate`)

Also, `username` must be a string with only lowercase letters, hyphens and/or
underscores and it must be less than or equal to 25 characters.

Result format:

| Name                           | Type   | Description                                          | Optional |
|--------------------------------|--------|------------------------------------------------------|----------|
| data                           | object |                                                      |          |
| data.type                      | string | Type of returned data (always `user`)                |          |
| data.id                        | number | User's identifier                                    |          |
| data.attributes                | object |                                                      |          |
| data.attributes.username       | string | User's username                                      |          |
| data.attributes.email          | string | User's email                                         |          |
| data.attributes.admin          | bool   | Either if user is admin or not                       | yes      |
| data.attributes.hasAcceptedTos | bool   | Either if user has accepted current terms of service |          |
| meta                           | object |                                                      |          |
| meta.token                     | string | A temporary token (1 month)                          |          |

Specific errors:

| Code              | Description                        |
|-------------------|------------------------------------|
| invalid           | Username's format is incorrect     |
| too\_long         | Username is too long               |
| taken             | Username already exists            |
| exclusion         | Username is blacklisted            |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"user": {"username": "dalecooper", "password": "secret"}, "token": "<activation_token>"}' \
       https://lessy.io/api/users/activations
```

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "username": "dalecooper",
      "email": "dale.cooper@lessy.io",
      "admin": false,
      "hasAcceptedTos": true
    }
  },
  "meta": {
    "token": "<token>"
  }
}
```

## `POST /api/users/activation_emails`

Resend an activation emails containing a token to create an account.

**This endpoint doesn't require an `Authorization` header.**

Parameters:

| Name       | Type   | Description  | Optional |
|------------|--------|--------------|----------|
| user       | object |              |          |
| user.email | string | User's email |          |

Result format: none.

Please note that if the account is already activated, the response will be
positive but no emails are sent.

Example:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"user": {"email": "dale.cooper@lessy.io"}}' \
       https://lessy.io/api/users/activation_emails
```

```raw
no content
```

## `POST /api/users/authorizations`

Authenticate a user and get a token valid for 1 month.

**This endpoint doesn't require an `Authorization` header.**

Parameters:

| Name                     | Type   | Description     | Optional |
|--------------------------|--------|-----------------|----------|
| username                 | string | User's username |          |
| password                 | string | User's password |          |

Result format:

| Name                           | Type   | Description                                          | Optional |
|--------------------------------|--------|------------------------------------------------------|----------|
| data                           | object |                                                      |          |
| data.type                      | string | Type of returned data (always `user`)                |          |
| data.id                        | number | User's identifier                                    |          |
| data.attributes                | object |                                                      |          |
| data.attributes.username       | string | User's username                                      |          |
| data.attributes.email          | string | User's email                                         |          |
| data.attributes.admin          | bool   | Either if user is admin or not                       | yes      |
| data.attributes.hasAcceptedTos | bool   | Either if user has accepted current terms of service |          |
| meta                           | object |                                                      |          |
| meta.token                     | string | A temporary token (1 month)                          |          |

Specific errors:

| Code              | Description                                |
|-------------------|--------------------------------------------|
| login\_failed     | Credentials are wrong or user is inactive. |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"username": "dalecooper", "password": "secret"}' \
       https://lessy.io/api/users/authorizations
```

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "username": "dalecooper",
      "email": "dale.cooper@lessy.io",
      "admin": false,
      "hasAcceptedTos": true
    }
  },
  "meta": {
    "token": "<token>"
  }
}
```

## `POST /api/users/me/terms_of_services`

Accept the current terms of service for the user.

**This endpoint requires an `Authorization` header but NOT that user accepted
terms of service.**

Parameters: none.

Result format:

| Name                           | Type   | Description                                          | Optional |
|--------------------------------|--------|------------------------------------------------------|----------|
| data                           | object |                                                      |          |
| data.type                      | string | Type of returned data (always `user`)                |          |
| data.id                        | number | User's identifier                                    |          |
| data.attributes                | object |                                                      |          |
| data.attributes.hasAcceptedTos | bool   | Either if user has accepted current terms of service |          |

Note: `hasAcceptedTos` should always be `true` here unless an extremely rare
race condition happens (i.e. new terms of service are effective just after the
creation of the user in DB).

Example:

```console
$ curl -H "Authorization: <token>" \
       -X POST \
       https://lessy.io/api/users/me/terms_of_services
```

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "hasAcceptedTos": true
    }
  }
}
```

## `POST /api/users/password_resets`

Set a reset password token and send an email to the user.

**This endpoint doesn't require an `Authorization` header.**

Parameters:

| Name       | Type   | Description  | Optional |
|------------|--------|--------------|----------|
| user       | object |              |          |
| user.email | string | User's email |          |

Result format: None

Specific errors:

| Code              | Description                                                      |
|-------------------|------------------------------------------------------------------|
| user\_inactive    | User did not activate its account and cannot reset its password. |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"user": { "email": "dale.cooper@lessy.io" }}' \
       https://lessy.io/api/users/password_resets
```

```raw
no content
```

## `POST /api/users/passwords`

Change the password of the user, using the reset password token from the email.

**This endpoint doesn't require an `Authorization` header.**

Parameters:

| Name          | Type   | Description            | Optional |
|---------------|--------|------------------------|----------|
| user          | object |                        |          |
| user.password | string | User's password to set |          |
| token         | string | Reset password token   |          |

**Important note:** the `token` is the one present in the link of the **reset
password email** (e.g. `https://lessy.io/password/9xNZHo_YR1J8SvzseL_S/new`)

Result format:

| Name                           | Type   | Description                                          | Optional |
|--------------------------------|--------|------------------------------------------------------|----------|
| data                           | object |                                                      |          |
| data.type                      | string | Type of returned data (always `user`)                |          |
| data.id                        | number | User's identifier                                    |          |
| data.attributes                | object |                                                      |          |
| data.attributes.username       | string | User's username                                      |          |
| data.attributes.email          | string | User's email                                         |          |
| data.attributes.admin          | bool   | Either if user is admin or not                       | yes      |
| data.attributes.hasAcceptedTos | bool   | Either if user has accepted current terms of service |          |
| meta                           | object |                                                      |          |
| meta.token                     | string | A temporary token (1 month)                          |          |

Specific errors:

| Code              | Description                                                      |
|-------------------|------------------------------------------------------------------|
| user\_inactive    | User did not activate its account and cannot reset its password. |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"user": {"password": "secret"}, "token": "<reset_token>"}' \
       https://lessy.io/api/users/passwords
```

```json
{
  "data": {
    "type": "user",
    "id": 1,
    "attributes": {
      "username": "dalecooper",
      "email": "dale.cooper@lessy.io",
      "admin": false,
      "hasAcceptedTos": true
    }
  },
  "meta": {
    "token": "<token>"
  }
}
```
