# Lessy technical documentation

Welcome on the technical documentation of Lessy. This documentation is aimed
to help you if you're considering to help us on the code or if you want to
install Lessy on your own server.

## About technology stack(s)

The first thing you should know is the technical stack. Lessy is based on two
distinct stacks:

- backend run over [**Ruby on Rails**](http://rubyonrails.org/) and provides a
  documented API
- frontend is based on [**VueJS**](https://vuejs.org/) and use this API as any
  other client

In order to simplify environment setups, we only provide documentation for
**Docker-based systems**. It also helps us to keep documentation simple,
up-to-date and avoid issues caused by specific system misconfiguration.

## Install Lessy on your server

If you just want to **run your own instance** instead of using [lessy.io](https://lessy.io),
you'll simply want to read our documentation about [**how to install Lessy in
production**](production_environment.md). This solution is only recommended if
you have technical background and you want to keep your data on your own
server.

## Development documentation

So you want to help us to build Lessy in order to be a better application?
That's great!

First, you'll need to **setup your [development environment](development_environment.md)**
in order to run Lessy on your own computer.

Then, you might be interested to know more about [**backend**](backend/index.md)
or [**frontend**](frontend/index.md) (or even both of them!). If **you're
interested by API** (for Lessy or for a third-party application), please have a
look to [our specific documentation](api/index.md).

Another important part of the development stack is the [feature flag
system](feature_flags.md). It helps us to push code in production even if the
feature is not complete.

You'll probably need to know about [**how we are running tests**](tests.md) so
you'll be able to run them by yourself.

You might want to look at the [`good first issue` label](https://github.com/lessy-community/lessy/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22+)
on GitHub to get started quickly. Those issues are considered as easy-enough
for newcomers and you should be able to finish them on your own. It doesn't
mean you'll have no questions: other developers will be pleased to help you!

And finally, it's time to learn [**how to open a pull request**](pull_request.md).

For those of us who have administrative rights on Lessy's repository, you may
need to know more about [**our release system**](release.md).
