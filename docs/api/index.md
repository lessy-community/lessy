# API overview

This document describes ressources accessible through Lessy API. It is still
under heavy development, so if you have questions, please open a ticket on [our
bugtracker](https://github.com/lessy-community/lessy/issues/).

This API only works with JSON and requests SHOULD use HTTPS only.

Please note all examples are based on lessy.io official service but you MUST
assume that users are not necessarily hosted on this server.

- [Authentication](authentication.md)
- [Users](users.md)
- [Projects](projects.md)
- [Tasks](tasks.md)
- [Errors](errors.md)

Also, a websocket is accessible to be notified of users' task and project
changes. Please refer to [the dedicated documentation](websocket.md) to know
more.
