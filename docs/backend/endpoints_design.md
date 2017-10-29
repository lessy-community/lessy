# Endpoints' design

Since the main goal of backend is to provide an API, designing endpoints is
very important. This document details a set of useful rules you must apply to
make sure your endpoints look great.

If you want to know more about the API, please have a look to [the API
overview](../api/index.md).

## Rules of route

A route is a HTTP verb + a noun. For instance `POST /projects` creates a
new project. `PATCH /projects/:id` is for updating a specific project.

Sometimes, a resource's attribute is more complicated than the others. For
instance, project's state needs `finished_at` to be set when state is set to
`finished`. That's the reason we have some specific endpoints such as `PUT
/projects/:id/state`.

Note in the previous example `state` is still a noun, not a verb. We could have
decided to have a `POST /projects/:id/update_state` but in this case we would
habe two verbs (`POST` and `update`) and it is more complicated to understand.

Sometimes, we need to manipulate sub-resources. For example, if you want to get
projects of current user, you can use `GET /me/projects`. Or if you need a
route to create a task for a specific project, you could create `POST /projects/:id/tasks`.
It's not always easy to decide when to use what, but keep in mind to stay
simple and never try to manipulate sub-resources of sub-resources.

Routes are defined in `config/routes.rb`.

## Rules of schema

Endpoints' output must always match with a basic schema. Output is always valid
JSON.

If endpoint returns data, it must have a `data` attribute:

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

`data` can either be an array or an object. An array must contain a list of
valid data objects. If there is no item to return, `data` still must be present
and empty. A valid data object has a `type` and `id` attributes. It also can
have `attributes` and `relationships`:

```json
{
  "data": {
    "type": "project",
    "id": 42,
    "attributes": {
      "name": "damn-good-coffee",
      "description": "",
      "startedAt": 0,
      "dueAt": 0,
      "stoppedAt": 0,
      "finishedAt": 0,
      "isInProgress": false
    },
    "relationships": {
      "user": {
        "data": { "type": "user", "id": 1 }
      },
      "tasks": {
        "data": []
      }
    }
  }
}
```

If endpoint is paginated, it must have a `links` object:

```json
{
  "data": [
    { "type": "project", "id": 24 },
    { "type": "project", "id": 42 }
  ],
  "links": {
    "first": "https://lessy.io/api/users/me/projects?page=1",
    "last": "https://lessy.io/api/users/me/projects?page=5",
    "prev": "https://lessy.io/api/users/me/projects?page=1",
    "next": "https://lessy.io/api/users/me/projects?page=3"
  }
}
```

Endpoints' outputs are written under `app/views/api`. Schemas are described
under `spec/support/api/schemas` according to the [JSON schema](http://json-schema.org/).

## Rules or error handling

Exceptions can happen when processing a request. For example, Rails raises a
`ActiveRecord::RecordNotFound` error if you try to access a resource that does
not exist. Exceptions are all handled in `ApiController` so they are rendered
as standard JSON.

Errors' output must match a schema as well. JSON must have a unique `errors`
key containing a list of error objects (even if there is only one error). An
error object has a `status` (i.e. corresponding HTTP status), a `code`
(specific to Lessy), a `title` and a `detail` keys. It also can have a
`source.pointer` key to indicate which part of the resource is concerned by the
error.

```json
{
  "errors": [
    {
      "status": "422 Unprocessable Entity",
      "code": "parameter_missing",
      "title": "Parameter is missing",
      "detail": "A parameter is missing or empty but it is required.",
      "source": {
        "pointer": "/project/due_at"
      }
    }
  ]
}
```

Errors are all listed in `app/errors/api_errors.rb`.
