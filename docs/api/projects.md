# Projects (API)

## `POST /api/users/me/projects`

Create a new project owned by current user.

Parameters:

| Name         | Type   | Description    | Optional |
|--------------|--------|----------------|----------|
| project      | object |                |          |
| project.name | string | Project's name |          |

Note: project's name MUST contain letters, numbers, underscores and hyphens
only. Also, it MUST be less or equal than 100 characters and unique per user.

Result format:

| Name                                 | Type   | Description                              | Optional |
|--------------------------------------|--------|------------------------------------------|----------|
| data                                 | object |                                          |          |
| data.type                            | string | Type of returned data (always `project`) |          |
| data.id                              | number | Project's identifier                     |          |
| data.attributes                      | object |                                          |          |
| data.attributes.name                 | string | Project's name                           |          |
| data.attributes.slug                 | string | Project's slug (URL fragment)            |          |
| data.attributes.description          | string | Project's description                    |          |
| data.attributes.state                | string | Project's state                          |          |
| data.attributes.startedAt            | number | Date when project started                |          |
| data.attributes.dueAt                | number | Date when project should finished        |          |
| data.attributes.pausedAt             | number | Date when project has been paused        |          |
| data.attributes.finishedAt           | number | Date when project finished               |          |
| data.attributes.createdAt            | number | Date when project has been created       |          |
| data.attributes.updatedAt            | number | Date when project has been updated       |          |
| data.relationships                   | object |                                          |          |
| data.relationships.user              | object | Related user reference                   |          |
| data.relationships.user.data         | object |                                          |          |
| data.relationships.user.data.type    | string | Type of data (always `user`)             |          |
| data.relationships.user.data.id      | number | User's identifier                        |          |
| data.relationships.tasks             | object | A list of tasks related to this project  |          |
| data.relationships.tasks.data        | array  |                                          |          |
| data.relationships.tasks.data[].type | string | Type of data (always `task`)             |          |
| data.relationships.tasks.data[].id   | number | Task's identifier                        |          |

**Important note :** this output may evolve quite soon!

Specific errors:

| Code              | Description                         |
|-------------------|-------------------------------------|
| invalid           | Name does not match required format |
| too\_long         | Name is too long                    |
| taken             | Name already exists for user        |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -H "Authorization: <token>" \
       -X POST \
       -d '{"project": {"name": "damn-good-coffee"}}' \
       https://lessy.io/api/users/me/projects
```

```json
{
  "data": {
    "type": "project",
    "id": 42,
    "attributes": {
      "name": "damn-good-coffee",
      "slug": "damn-good-coffee",
      "description": "",
      "state": "newed",
      "startedAt": 0,
      "dueAt": 0,
      "pausedAt": 0,
      "finishedAt": 0,
      "createdAt": 1507446226,
      "updatedAt": 1507446226
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

## `GET /api/users/me/projects`

List projects owned by current user. This endpoint is paginated and return a
maximum of 25 items per page.

Parameters:

| Name      | Type   | Description                          | Optional |
|-----------|--------|--------------------------------------|----------|
| page      | number | Projects' page to fetch (default: 1) | yes      |

Result format:

| Name                                   | Type   | Description                              | Optional |
|----------------------------------------|--------|------------------------------------------|----------|
| data                                   | array  |                                          |          |
| data[].type                            | string | Type of returned data (always `project`) |          |
| data[].id                              | number | Project's identifier                     |          |
| data[].attributes                      | object |                                          |          |
| data[].attributes.name                 | string | Project's name                           |          |
| data[].attributes.slug                 | string | Project's slug (URL fragment)            |          |
| data[].attributes.description          | string | Project's description                    |          |
| data[].attributes.state                | string | Project's state                          |          |
| data[].attributes.startedAt            | number | Date when project started                |          |
| data[].attributes.dueAt                | number | Date when project should finished        |          |
| data[].attributes.pausedAt             | number | Date when project has been paused        |          |
| data[].attributes.finishedAt           | number | Date when project finished               |          |
| data[].attributes.createdAt            | number | Date when project has been created       |          |
| data[].attributes.updatedAt            | number | Date when project has been updated       |          |
| data[].relationships                   | object |                                          |          |
| data[].relationships.user              | object | Related user reference                   |          |
| data[].relationships.user.data         | object |                                          |          |
| data[].relationships.user.data.type    | string | Type of data (always `user`)             |          |
| data[].relationships.user.data.id      | number | User's identifier                        |          |
| data[].relationships.tasks             | object | A list of tasks related to this project  |          |
| data[].relationships.tasks.data        | array  |                                          |          |
| data[].relationships.tasks.data[].type | string | Type of data (always `task`)             |          |
| data[].relationships.tasks.data[].id   | number | Task's identifier                        |          |
| links                                  | object |                                          |          |
| links.first                            | string | Link to the first page of pagination     |          |
| links.last                             | string | Link to the last page of pagination      |          |
| links.prev                             | string | Link to the previous page of pagination  | yes      |
| links.next                             | string | Link to the next page of pagination      | yes      |

**Important note :** this output may evolve quite soon!

Specific errors: none.

Example:

```console
$ curl -H "Authorization: <token>" https://lessy.io/api/users/me/projects
```

```json
{
  "data": [
    {
      "type": "project",
      "id": 24,
      "attributes": {
        "name": "black-lodge",
        "slug": "black-lodge",
        "description": "A mysterious dark place",
        "state": "started",
        "startedAt": 639532800,
        "dueAt": 1504396800,
        "pausedAt": 0,
        "finishedAt": 0,
        "createdAt": 639529200,
        "updatedAt": 639536400
      },
      "relationships": {
        "user": {
          "data": { "type": "user", "id": 1 }
        },
        "tasks": {
          "data": [
            { "type": "task", "id": 1 },
            { "type": "task", "id": 3 }
          ]
        }
      }
    },
    {
      "type": "project",
      "id": 42,
      "attributes": {
        "name": "damn-good-coffee",
        "slug": "damn-good-coffee",
        "description": "",
        "state": "newed",
        "startedAt": 0,
        "dueAt": 0,
        "pausedAt": 0,
        "finishedAt": 0,
        "createdAt": 1507446226,
        "updatedAt": 1507446226
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
  ],
  "links": {
    "first": "https://lessy.io/api/users/me/projects?page=1",
    "last": "https://lessy.io/api/users/me/projects?page=1"
  }
}
```

## `GET /api/projects/:id`

Return a given project.

Parameters: none.

Result format:

| Name                                 | Type   | Description                              | Optional |
|--------------------------------------|--------|------------------------------------------|----------|
| data                                 | object |                                          |          |
| data.type                            | string | Type of returned data (always `project`) |          |
| data.id                              | number | Project's identifier                     |          |
| data.attributes                      | object |                                          |          |
| data.attributes.name                 | string | Project's name                           |          |
| data.attributes.slug                 | string | Project's slug (URL fragment)            |          |
| data.attributes.description          | string | Project's description                    |          |
| data.attributes.state                | string | Project's state                          |          |
| data.attributes.startedAt            | number | Date when project started                |          |
| data.attributes.dueAt                | number | Date when project should finished        |          |
| data.attributes.pausedAt             | number | Date when project has been paused        |          |
| data.attributes.finishedAt           | number | Date when project finished               |          |
| data.attributes.createdAt            | number | Date when project has been created       |          |
| data.attributes.updatedAt            | number | Date when project has been updated       |          |
| data.relationships                   | object |                                          |          |
| data.relationships.user              | object | Related user reference                   |          |
| data.relationships.user.data         | object |                                          |          |
| data.relationships.user.data.type    | string | Type of data (always `user`)             |          |
| data.relationships.user.data.id      | number | User's identifier                        |          |
| data.relationships.tasks             | object | A list of tasks related to this project  |          |
| data.relationships.tasks.data        | array  |                                          |          |
| data.relationships.tasks.data[].type | string | Type of data (always `task`)             |          |
| data.relationships.tasks.data[].id   | number | Task's identifier                        |          |

**Important note :** this output may evolve quite soon!

Specific errors: none.

Example:

```console
$ curl -H "Authorization: <token>" https://lessy.io/api/projects/42
```

```json
{
  "data": {
    "type": "project",
    "id": 42,
    "attributes": {
      "name": "damn-good-coffee",
      "slug": "damn-good-coffee",
      "description": "",
      "state": "newed",
      "startedAt": 0,
      "dueAt": 0,
      "pausedAt": 0,
      "finishedAt": 0,
      "createdAt": 1507446226,
      "updatedAt": 1507446226
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

## `PATCH /api/projects/:id`

Update a given project.

Parameters:

| Name                | Type   | Description                    | Optional |
|---------------------|--------|--------------------------------|----------|
| id                  | number | Project's id                   |          |
| project             | object |                                |          |
| project.name        | string | Project's name                 | yes      |
| project.description | string | Project's description          | yes      |
| project.due\_at     | number | Project's due date (timestamp) | yes      |

Note: same requirements apply to project's name as for creation. Also, `due_at`
cannot be changed while project is `newed`.

Result format:

| Name                                 | Type   | Description                              | Optional |
|--------------------------------------|--------|------------------------------------------|----------|
| data                                 | object |                                          |          |
| data.type                            | string | Type of returned data (always `project`) |          |
| data.id                              | number | Project's identifier                     |          |
| data.attributes                      | object |                                          |          |
| data.attributes.name                 | string | Project's name                           |          |
| data.attributes.slug                 | string | Project's slug (URL fragment)            |          |
| data.attributes.description          | string | Project's description                    |          |
| data.attributes.state                | string | Project's state                          |          |
| data.attributes.startedAt            | number | Date when project started                |          |
| data.attributes.dueAt                | number | Date when project should finished        |          |
| data.attributes.pausedAt             | number | Date when project has been paused        |          |
| data.attributes.finishedAt           | number | Date when project finished               |          |
| data.attributes.createdAt            | number | Date when project has been created       |          |
| data.attributes.updatedAt            | number | Date when project has been updated       |          |
| data.relationships                   | object |                                          |          |
| data.relationships.user              | object | Related user reference                   |          |
| data.relationships.user.data         | object |                                          |          |
| data.relationships.user.data.type    | string | Type of data (always `user`)             |          |
| data.relationships.user.data.id      | number | User's identifier                        |          |
| data.relationships.tasks             | object | A list of tasks related to this project  |          |
| data.relationships.tasks.data        | array  |                                          |          |
| data.relationships.tasks.data[].type | string | Type of data (always `task`)             |          |
| data.relationships.tasks.data[].id   | number | Task's identifier                        |          |

**Important note :** this output may evolve quite soon!

Specific errors:

| Code              | Description                         |
|-------------------|-------------------------------------|
| invalid           | Name does not match required format |
| too\_long         | Name is too long                    |
| taken             | Name already exists for user        |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -H "Authorization: <token>" \
       -X PATCH \
       -d '{"project": {"description": "Wait a minute! Wait a minute! [...] You know, this is, excuse me, a damn fine cup of coffee."}}' \
       https://lessy.io/api/projects/42
```

```json
{
  "data": {
    "type": "project",
    "id": 42,
    "attributes": {
      "name": "damn-good-coffee",
      "slug": "damn-good-coffee",
      "description": "Wait a minute! Wait a minute! [...] You know, this is, excuse me, a damn fine cup of coffee.",
      "state": "newed",
      "startedAt": 0,
      "dueAt": 0,
      "pausedAt": 0,
      "finishedAt": 0,
      "createdAt": 1507446226,
      "updatedAt": 1507448026
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

## `PUT /api/projects/:id/state`

Update a given project's state.

Parameters:

| Name                 | Type   | Description           | Optional |
|----------------------|--------|-----------------------|----------|
| id                   | number | Project's id          |          |
| project              | object |                       |          |
| project.state        | string | Project's state       |          |
| project.due\_at      | number | Project's due date    | yes      |
| project.finished\_at | number | Project's finish date | yes      |

Note: possible values of `state` are `started`, `paused` and `finished`. A
created project's state is `newed`. State follow this state's machine:

```raw
                     +---------+
                     | newed   |
                     +---+-----+
                         |
                         |start(due_at)
                         |
+---------+   pause  +---v-----+                       +---------+
| paused  <----------+started  +----------------------->finished |
+-------+-+          +---^-----+                       +---------+
        |                |        finish(finished_at)
        +----------------+
         restart(due_at?)
```

Also, following rules apply:

- `due_at` must be set on `start` action and can be set on `restart` action. It
  cannot be set on other actions. It must be set after today.
- `started_at` is set to now on `start` action
- no more than three projects can be `started` at the same time for a given
  user.
- `paused_at` is set to now on `pause` action and to `null` on `restart`
  action.
- `finished_at` can be set on `finish` action only and must be included between
  `started_at` and today (included).

Result format:

| Name                                 | Type   | Description                              | Optional |
|--------------------------------------|--------|------------------------------------------|----------|
| data                                 | object |                                          |          |
| data.type                            | string | Type of returned data (always `project`) |          |
| data.id                              | number | Project's identifier                     |          |
| data.attributes                      | object |                                          |          |
| data.attributes.name                 | string | Project's name                           |          |
| data.attributes.slug                 | string | Project's slug (URL fragment)            |          |
| data.attributes.description          | string | Project's description                    |          |
| data.attributes.state                | string | Project's state                          |          |
| data.attributes.startedAt            | number | Date when project started                |          |
| data.attributes.dueAt                | number | Date when project should finished        |          |
| data.attributes.pausedAt             | number | Date when project has been paused        |          |
| data.attributes.finishedAt           | number | Date when project finished               |          |
| data.attributes.createdAt            | number | Date when project has been created       |          |
| data.attributes.updatedAt            | number | Date when project has been updated       |          |
| data.relationships                   | object |                                          |          |
| data.relationships.user              | object | Related user reference                   |          |
| data.relationships.user.data         | object |                                          |          |
| data.relationships.user.data.type    | string | Type of data (always `user`)             |          |
| data.relationships.user.data.id      | number | User's identifier                        |          |
| data.relationships.tasks             | object | A list of tasks related to this project  |          |
| data.relationships.tasks.data        | array  |                                          |          |
| data.relationships.tasks.data[].type | string | Type of data (always `task`)             |          |
| data.relationships.tasks.data[].id   | number | Task's identifier                        |          |

**Important note :** this output may evolve quite soon!

Specific errors:

| Code                            | Description                                                     |
|---------------------------------|-----------------------------------------------------------------|
| must\_be\_set                   | Attribute given in path must be set                             |
| cannot\_be\_set                 | Attribute given in path cannot be set                           |
| cannot\_be\_before\_started\_at | Attribute given in path cannot be before `started_at` attribute |
| cannot\_be\_after\_today        | Attribute given in path cannot be after `today`                 |
| reached\_max\_started           | User already has 3 started projects                             |
| invalid\_transition             | Project cannot reach given state                                |

Example:

```console
$ curl -H "Content-Type: application/json" \
       -H "Authorization: <token>" \
       -X PUT \
       -d '{"project": {"state": "started", "due_at": 1545696000}}' \
       https://lessy.io/api/projects/42/state
```

```json
{
  "data": {
    "type": "project",
    "id": 42,
    "attributes": {
      "name": "damn-good-coffee",
      "slug": "damn-good-coffee",
      "description": "Wait a minute! Wait a minute! [...] You know, this is, excuse me, a damn fine cup of coffee.",
      "state": "started",
      "startedAt": 1507449826,
      "dueAt": 1545696000,
      "pausedAt": 0,
      "finishedAt": 0,
      "createdAt": 1507446226,
      "updatedAt": 1507449826
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
