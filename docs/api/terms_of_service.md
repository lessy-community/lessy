# Terms of service (API)

## `GET /api/terms_of_services/current`

Return the current terms applicable to the service.

**This endpoint doesn't require an `Authorization` header.**

Parameters: none.

Result format:

| Name                        | Type   | Description                                       | Optional |
|-----------------------------|--------|---------------------------------------------------|----------|
| data                        | object |                                                   | yes      |
| data.type                   | string | Type of returned data (always `terms_of_service`) |          |
| data.id                     | number | Terms of service's identifier                     |          |
| data.attributes             | object |                                                   |          |
| data.attributes.content     | string | Terms of service's content (HTML)                 |          |
| data.attributes.version     | string | Terms of service's version (unique)               |          |
| data.attributes.effectiveAt | number | Since when the terms apply to the service         |          |

Note: the endpoint can return a `no_content` response if there is no terms of
service.

Example:

```console
$ curl https://lessy.io/api/terms_of_services/current
```

```json
{
  "data": {
    "type": "terms_of_service",
    "id": 1,
    "attributes": {
      "content": "[...]",
      "version": "2018-06",
      "effectiveAt": 1529855818
    }
  }
}
```
