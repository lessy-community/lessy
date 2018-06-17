# Root (API)

## `GET /api`

Return information about the server.

**This endpoint doesn't require an `Authorization` header.**

Parameters: none.

Result format:

| Name                 | Type   | Description                               | Optional |
|----------------------|--------|-------------------------------------------|----------|
| registrationDisabled | bool   | Either if registrations are closed or not |          |

Example:

```console
$ curl https://lessy.io/api
```

```json
{
  "registrationDisabled": true
}
```
