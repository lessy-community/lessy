# Project Zero

[![Build Status](https://travis-ci.org/marienfressinaud/project-zero.svg?branch=master)](https://travis-ci.org/marienfressinaud/project-zero)

## Database configuration

Project Zero uses PostgreSQL as default database so make sure you've installed
it. Then, create the user `postgres` and database:

```bash
$ createuser --createdb -P postgres
$ rails db:setup
```

## Running tests

Tests are using [RSpec](http://rspec.info/). To run tests:

```bash
$ bundle exec rspec
```

Tests' suite is running against [TravisCI](https://travis-ci.org/marienfressinaud/project-zero).
Pull requests must pass tests to be merged.
