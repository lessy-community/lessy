# Install Lessy for development

## Configure PostgreSQL

Lessy uses PostgreSQL as database by default. You may install it through your
distribution's packages manager. User and password are `postgres`. You may
create it as following:

```bash
$ createuser --createdb -P postgres
```

## Configure backend

Lessy is built with [Rails](http://rubyonrails.org/) (backend) and
[VueJS](https://vuejs.org/) (frontend). You have to run both of them to get
Lessy running.

First, make sure you have a ruby environment installed on your system (you may
use [rbenv](https://github.com/rbenv/rbenv) for instance).

```bash
$ git clone git@github.com:marienfressinaud/lessy.git
$ cd lessy
lessy$ rbenv install
lessy$ gem install bundler
lessy$ bundle install --path vendor  # install backend's dependencies
lessy$ bundle exec rails db:setup  # setup the database
lessy$ bundle exec rails server  # run the backend
```

Congratulations, you have the backend running on the port 3000.

## Configure frontend

Now, you should configure frontend environment which come with hot-reloading so
you don't have to build frontend each time you change a line of code. If you
want to build the frontend instead so the backend can serve it, please have a
look at the ["deployment" section](deployment.md).

Make sure you have a node environment installed on your system (you may want to
use [nvm](https://github.com/creationix/nvm)):

```bash
lessy$ cd client
lessy/client$ npm install
lessy/client$ npm run dev
```

The last line should have opened a new window in your browser at
http://localhost:8080 and serve the frontend. All the AJAX requests to the
backend are proxified to http://localhost:3000 (served by Rails).

## Connect to the app

You can login into the app with following credentials: `dalecooper` / `secret`.
A bunch of fake data have been generated for you so you can start to code
quickly.
