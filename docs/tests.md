# Running tests

In this section, we assume you already have installed development environment
and you are running it on Docker.

Tests are using [RSpec](http://rspec.info/) (backend) and [Jest](http://facebook.github.io/jest/) +
[vue-test-utils](https://vue-test-utils.vuejs.org/en/).

To execute them, just run:

```console
$ make test
$ # or
$ make test-back
$ make test-front
```

This command calls `rspec` and `jest` commands with docker-compose and it
passes `docker-compose-test.yml` in argument which is an adapted and simpler
version of `docker-compose-dev.yml`.

Tests' suite is run against [TravisCI](https://travis-ci.org/marienfressinaud/lessy).
Pull requests must pass tests to be merged so please make sure it's all green
before asking for a review (but you still can ask for help!)

If you want to know more about how to write tests, please have a look to the
dedicated document [for backend](backend/writing_tests.md) and [for
frontend](frontend/writing_tests.md).
