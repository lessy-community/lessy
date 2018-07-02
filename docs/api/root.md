# Root (API)

## `GET /api`

Return information about the server.

**This endpoint doesn't require an `Authorization` header.**

Parameters: none.

Result format:

| Name                 | Type   | Description                               | Optional |
|----------------------|--------|-------------------------------------------|----------|
| registrationDisabled | bool   | Either if registrations are closed or not |          |
| tosVersion           | string | Version of current terms of service       | yes      |

Example:

```console
$ curl https://lessy.io/api
```

```json
{
  "registrationDisabled": true,
  "tosVersion": "2018-06"
}
```
