# Errors (API)

There are different possible errors that you can receive as a response to a
request.

Errors are NEVER sent with a successful HTTP status.

An error response always matches with the following format:

| Name                    | Type   | Description                                                    | Optional |
|-------------------------|--------|----------------------------------------------------------------|----------|
| errors                  | array  |                                                                |          |
| errors[].status         | string | The HTTP status related to this specific error                 |          |
| errors[].code           | string | A specific application code error                              |          |
| errors[].title          | string | A human-readable summary of the error                          |          |
| errors[].detail         | string | A human-readable explanation of the error                      |          |
| errors[].source         | object | An object containing information about the source of the error | yes      |
| errors[].source.pointer | string | A pointer indicating the specific resource of field in error   |          |

Note: if several errors has different `status` code, the HTTP response will be
the most generally applicable error code.

Here is a non-exhaustive list of errors:

| Code                | Description                                                                                 |
|---------------------|---------------------------------------------------------------------------------------------|
| missing\_endpoint   | Endpoint does not exist (it might be you are using the wrong HTTP verb).                    |
| unauthorized        | Token is not valid or has expired.                                                          |
| tos\_not\_accepted  | User has not accepted the current terms of service.                                         |
| parameter\_missing  | A required parameter is missing in the request. `source.pointer` should indicate which one. |
| record\_not\_found  | You try to reach a record which does not exist. It might be that you don't have permission. |

Most specific errors are indicated for concerned endpoints.

Example:

```console
$ curl https://lessy.io/api/unknown-endpoint
```

```json
{
  "errors": [
    {
      "status": "404 Not Found",
      "code": "missing_endpoint",
      "title": "Missing endpoint",
      "detail": "Endpoint you try to reach does not exist, you might be using wrong HTTP verb."
    }
  ]
}
```
