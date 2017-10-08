# Users (API)

## `GET /api/users/me`

Return the user corresponding to the given token.

Parameters: none.

Result format:

| Name                     | Type   | Description                           | Optional |
|--------------------------|--------|---------------------------------------|----------|
| data                     | object |                                       |          |
| data.type                | string | Type of returned data (always `user`) |          |
| data.id                  | number | User's identifier                     |          |
| data.attributes          | object |                                       |          |
| data.attributes.username | string | User's username                       |     x    |
| data.attributes.email    | string | User's email                          |          |

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
      "email": "dale.cooper@lessy.io"}
    }
  }
}
```

## `POST /api/users`

Create a new user on Lessy. This action sends an email to the given address
with a token required to activate the user.

**This endpoint doesn't require a `Authorization` header.**

Parameters:

| Name       | Type   | Description  | Optional |
|------------|--------|--------------|----------|
| user       | object |              |          |
| user.email | string | User's email |          |

Result format:

| Name                     | Type   | Description                           | Optional |
|--------------------------|--------|---------------------------------------|----------|
| data                     | object |                                       |          |
| data.type                | string | Type of returned data (always `user`) |          |
| data.id                  | number | User's identifier                     |          |
| data.attributes          | object |                                       |          |
| data.attributes.email    | string | User's email                          |          |
| meta                     | object |                                       |          |
| meta.token               | string | A temporary token (24 hours)          |          |

Note: the returned token is only valid for 24 hours. To obtain full access, you
need to validate the user's account.

Specific errors:

| Code              | Description                        |
|-------------------|------------------------------------|
| taken             | Email address already exists       |

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
      "email": "dale.cooper@lessy.io"
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

**This endpoint doesn't require a `Authorization` header.**

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

| Name                     | Type   | Description                           | Optional |
|--------------------------|--------|---------------------------------------|----------|
| data                     | object |                                       |          |
| data.type                | string | Type of returned data (always `user`) |          |
| data.id                  | number | User's identifier                     |          |
| data.attributes          | object |                                       |          |
| data.attributes.username | string | User's username                       |          |
| data.attributes.email    | string | User's email                          |          |
| meta                     | object |                                       |          |
| meta.token               | string | A temporary token (1 month)           |          |

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
      "email": "dale.cooper@lessy.io"
    }
  },
  "meta": {
    "token": "<token>"
  }
}
```

## `POST /api/users/authorizations`

Authenticate a user and get a token valid for 1 month.

**This endpoint doesn't require a `Authorization` header.**

Parameters:

| Name                     | Type   | Description     | Optional |
|--------------------------|--------|-----------------|----------|
| username                 | string | User's username |          |
| password                 | string | User's password |          |

Result format:

| Name                     | Type   | Description                           | Optional |
|--------------------------|--------|---------------------------------------|----------|
| data                     | object |                                       |          |
| data.type                | string | Type of returned data (always `user`) |          |
| data.id                  | number | User's identifier                     |          |
| data.attributes          | object |                                       |          |
| data.attributes.username | string | User's username                       |          |
| data.attributes.email    | string | User's email                          |          |
| meta                     | object |                                       |          |
| meta.token               | string | A temporary token (1 month)           |          |

Specific errors:

| Code              | Description                                |
|-------------------|--------------------------------------------|
| login\_failed     | Credentials are wrong or user is inactive. |

Example:

```json
$ curl -H "Content-Type: application/json" \
       -X POST \
       -d '{"username": "dalecooper", "password": "secret"}' \
       https://lessy.io/api/users/authorizations

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
