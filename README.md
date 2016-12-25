# Project Zero

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
