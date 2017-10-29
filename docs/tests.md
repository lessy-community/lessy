# Running tests

In this section, we assume you already have installed development environment
and you are running it on Docker.

For the moment, tests exist for backend only and we are using [RSpec](http://rspec.info/).

To execute them, just run:

```console
$ make test
```

This command calls `rspec` command with docker-compose and it passes
`docker-compose-test.yml` in argument which is an adapted and simpler version
of `docker-compose-dev.yml`.

Tests' suite is run against [TravisCI](https://travis-ci.org/marienfressinaud/lessy).
Pull requests must pass tests to be merged so please make sure it's all green
before asking for a review!

If you want to know more about how to write tests, please have a look to [the
dedicated document](backend/writing_tests.md).
