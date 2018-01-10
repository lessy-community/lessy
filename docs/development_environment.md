# Install Lessy for development

Lessy is built with [Rails](http://rubyonrails.org/) (backend) and
[VueJS](https://vuejs.org/) (frontend). You'll also need a PostgreSQL database.

We are using Docker to provide a standard environment for development. It is
the only official supported method to develop even if other more "traditional"
methods (e.g. rbenv to manage Ruby version + nvm for Node) should probably work
too. The reason for that is we can't test every configuration by ourself and we
don't want to support methods that we don't use every day.

## Configure Docker and docker-compose

You must have Docker running on your computer. To learn how to install Docker,
please refer to [the official documentation](https://docs.docker.com/engine/installation/).

Then, make sure you have docker-compose installed. It will orchestrate required
services (i.e. database and application for the moment). Have a look to [their
documentation](https://docs.docker.com/compose/install/) to install it.

## TL;DR

Here are the two commands you need to know to start the application:

```console
$ make build     # create Docker image
$ make db-setup  # set up the database
$ make run       # starts the application
```

Then, go to http://localhost:5000, default credentials are `dalecooper` / `secret`.

But now you won 5 minutes by reading this TL;DR, we strongly encourage you to
read the rest of this documentation so you understand what's going on under the
hood.

## How it works

You might be interesting on how we use Docker to manage our environment.

First of all, Rails and Node environments are described in `Dockerfile.dev`.
This file details steps to apply on the base image (i.e. a ruby-alpine image)
to install all the dependencies Lessy needs to be run. The final instruction
gives the command to start Lessy (i.e. `bundle exec foreman start`). This
command starts Rails (backend) and a small Node server to serve the frontend
(it is described in `Procfile`).

This Dockerfile needs to be built in order to obtain an image:

```console
$ docker build -f Dockerfile.dev -t lessy-dev .
$ docker run -p 3000:3000 -p 5000:5000 -v `pwd`:/app -v /app/client/node_modules lessy-dev
```

But we all can agree it's quite painful to use and we still don't have any
PostgreSQL database running!

That's where docker-compose helps us. `docker-compose-dev.yml` already
describes how to build our image and how to run a container based on it. You
don't have to precise ports nor shared volumes, it's already there! Plus, it
describes how to run a `postgres` container. All you have to do then is
executing:

```console
$ docker-compose -f docker-compose-dev.yml up --build
```

And tadaaa! You can access Lessy on http://localhost:5000 (please note the
backend is running on port 3000). You can then stop docker-compose with
`ctrl+c` or:

```console
$ docker-compose -f docker-compose-dev.yml stop  # stops containers but don't remove them
$ docker-compose -f docker-compose-dev.yml down  # stops and remove containers
```

## Setup database

Our application is running but we didn't setup database so you can't log in
yet. You need to run `rails db:setup` in a container first:

```console
$ docker-compose -f docker-compose-dev.yml run --rm lessy bundle exec rails db:setup
```

## Shortcuts

You may think:

> Wow! Really? What's this messy command?

and you might be right. That's why we have a `Makefile` to hide complexity of
very common commands. You can simply execute:

```console
$ make db-setup
```

That's all! We also provide some useful shortcuts for previous commands:

```console
$ make build  # create Docker image
$ make run    # starts containers/application
$ make stop   # stops containers but don't remove them
$ make clean  # stops and remove containers
```

If you're not sure of what a command does or if you want a complete list of
`make` commands, just type:

```console
$ make
$ # or
$ make help
```

## Connect to the app

Now, you can login into the app with following credentials: `dalecooper` /
`secret`. A bunch of fake data have been generated for you so you can start to
code quickly.

## Final notes

This Docker environment is quite new on Lessy and configuration might need to
evolve. If you feel that it's painful to use as it is, please [open a ticket on
GitHub](https://github.com/lessy-community/lessy/issues) so we can figure out
how we can help you!
