# Writing tests (frontend)

We use [Jest](http://facebook.github.io/jest/) + [vue-test-utils](https://vue-test-utils.vuejs.org/en/)
for our frontend tests. For the moment, the frontend suite test is very basic
but we strongly encourage you to write tests when adding new features.

Tests are written under `client/spec` directory.

And, yes, we know: testing the frontend is never easy nor pleasant. But let's
try!

## What to test?

Actually, we only test presentational components: there are very basic (few
JavaScript interactions) and they do not require complex mocking. These tests
are not very interesting since they are already taking more than 10 seconds for
less than 20 tests and the code which is tested is extremely simple! However,
they gave insight of what is possible to test.

Later, we would like to test container components wrapping these components
since they handle more business logic. Store might be tested as well.

However, we lack of examples for the moment. If you have any question or
suggestion, don't hesitate to [open a ticket on GitHub](https://github.com/lessy-community/lessy/issues).
