## Configure PostgreSQL

Project Zero uses PostgreSQL as database by default. You may install it through
your distribution's packages manager. User and password are `postgres`. You may
create it as following:

```bash
$ createuser --createdb -P postgres
```

## Install project-zero (development)

Project Zero is built with [Rails](http://rubyonrails.org/) (backend) and
[VueJS](https://vuejs.org/) (frontend). You have to run both of them to get
Project Zero running.

First, make sure you have a ruby environment installed on your system (you may
use [rbenv](https://github.com/rbenv/rbenv) for instance).

```bash
$ git clone git@github.com:marienfressinaud/project-zero.git
$ cd project-zero
project-zero$ rbenv install
project-zero$ gem install bundler
project-zero$ bundle install  # install backend's dependencies
project-zero$ bundle exec rails db:setup  # setup the database
project-zero$ bundle exec rails server  # run the backend
```

Congratulations, you have the backend running on the port 3000 but it does not
serve the client yet (see "Build project-zero" section for that). Howeverer,
for development, you'll prefer to run the frontend with hot-reloading instead
of building it each time you change a line of code.

Make sure you have a node environment installed on your system (you may want to
use [nvm](https://github.com/creationix/nvm)):

```bash
project-zero$ cd client
project-zero/client$ npm install
project-zero/client$ npm run dev
```

The last line should have opened a new window in your browser at
http://localhost:8080 and serve the frontend. All the AJAX requests to the
backend are proxified to http://localhost:3000 (served by Rails).

## Build project-zero

Frontend can be served by Rails as well, that's what should be done in
production. The following command package frontend and copy files into
`public`:

```bash
project-zero/client$ npm run build
```

Now, http://localhost:3000 serves the frontend.
