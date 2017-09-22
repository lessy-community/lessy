# Deploy Lessy on your server

## Install packages

First, make sure you have the following packages installed on your server: `git
postgresql-server postgresql-dev(el) ruby nodejs`.

For the two last, you may prefer to install them through
[rbenv](https://github.com/rbenv/rbenv) and
[nvm](https://github.com/creationix/nvm) so you can manage multiple versions
of Ruby and NodeJS on the same server. Note NodeJS is required to build the
frontend but you can do it on your PC and then upload the built package; this
solution will not be presented though.

## Create a dedicated user

Even if it is not required, you should create a user dedicated to Lessy
on your system:

```
root# adduser lessy
root# chmod 755 /home/lessy
```

## Install database

Once `postgresql-server` is installed, you should configure it:

```bash
root# postgresql-setup initdb
root# systemctl enable postgresql
root# systemctl start postgresql
```

You should consider to create a new Postgre user as well (note from now, `$`
prompt indicates that you should be connected with `lessy` user you
created above):

```bash
$ sudo -u postgres psql
postgres=# CREATE USER lessy WITH CREATEDB PASSWORD '<password>';
```

For more information, please refer to the official [PostgreSQL
documentation](https://wiki.postgresql.org/wiki/First_steps).

## Get Lessy and configure it

```bash
~$ git clone -b https://github.com/marienfressinaud/lessy.git
~$ cd lessy
lessy$ gem install bundler
lessy$ RAILS_ENV=production bundle install --deployment --without test development --path vendor
```

If you face any problem during installation, please open a ticket [on
GitHub](https://github.com/marienfressinaud/lessy/issues).

I spent quite a long time figuring out why building `pg` gem was failing on my
server (CentOS). I'm using a custom package of `pgsql` so I can use the latest
version, but Bundler still try to build the gem with an incorrect configuration,
I had to run these two commands before `bundle install` to make it works:

```bash
lessy$ export ARCHFLAGS="-arch x86_64"
lessy$ bundle config build.pg --with-pg-config=/usr/pgsql-9.6/bin/pg_config
```

It's time to add the required environment variables, in your `~/.bashrc`, add the
following lines and adapt them to your situation:

```
export PROJECTZERO_HOST=<your.domain.com>
export PROJECTZERO_HTTPS=true  # only if your server is configured to serve https
export DATABASE_URL=postgres://<username>:<password>@localhost:5432/<db name>
export RAILS_ENV=production
export SECRET_KEY_BASE=<your secret key>
```

Note `SECRET_KEY_BASE` can be generated with `bundle exec rails secret`.

Then, run `source ~/.bashrc` to load these variables in your session.

## Setup database

Simply run:

```bash
lessy$ bundle exec rails db:create db:schema:load
```

It's the final test to check if your Postgre user is well configured! :). If
the command fails, with some `PG::ConnectionBad: FATAL:  Ident authentication
failed for user` error message, you should check your [`pg_hba.conf`
file](https://www.postgresql.org/docs/9.1/static/auth-pg-hba-conf.html) and
change the auth method.

## Build frontend

Frontend must now be built and moved under `public` folder. Make
sure you have `npm` installed and run:

```bash
lessy$ cd client
lessy/client$ npm install
lessy/client$ npm run build
```

## Serve the application with Apache

Now we need to serve the application by a web server. There are a lot of
possibilities but only one is described here. Advantage is it's very simple.

First, run the application as you would normally, but with `screen`:

```bash
lessy$ screen bundle exec rails s -p 8081
```

You can leave `screen` by typing `ctrl+a d`. Application is now running in
background, served by `puma` on port 8081.

Last step is to add Apache configuration. For that, you'll need to install
Apache mods `proxy` and `proxy_http` and provide a `VirtualHost` configuration:

```
<VirtualHost *:80>
    ServerAdmin your@emailaddress.com
    DocumentRoot /home/lessy/lessy/public
    ServerName your.domain.com

    <Location /static>
        ProxyPass !
    </Location>
    <Directory /home/lessy/lessy/public/static>
        Require all granted
    </Directory>

    ProxyPass / http://127.0.0.1:8081/
    ProxyPassReverse / http://127.0.0.1:8081/
</VirtualHost>
```

Note the `ProxyPass !` line which make `static` files (i.e. the frontend)
served by Apache instead of Rails.

Now reload the server:

```bash
root# systemctl reload httpd  # or apache2 depending on what is your system
```

You should now be able to access Lessy at http://your.domain.com.

## Update

For each new version of Lessy, you'll need to get the new source code, migrate
the database, install new gems (Ruby) and packages (NodeJS) and restart the
Rails server. The following commands try to be as exhaustive as possible:

```bash
lessy$ # First, stop the server (I'll try to find a better method later ;))
lessy$ screen -r
lessy$ <ctrl+c>
lessy$
lessy$ # Let's get the new code
lessy$ git pull
lessy$ git checkout <tag version>  # to adapt with desired version
lessy$
lessy$ # You'll need to do that ONLY if we updated Ruby version
lessy$ # Please check the changelog to know if it applies to you
lessy$ rbenv install
lessy$ gem install bundler
lessy$
lessy$ # Then, update the backend
lessy$ RAILS_ENV=production bundle install --deployment --without test development --path vendor
lessy$ bundle exec rails db:migrate
lessy$
lessy$ # After that, we update the client and rebuild the frontend
lessy$ cd client
lessy/client$ npm install  # if anything goes wrong here, try to remove the node_modules folder
lessy/client$ npm run build
lessy/client$ cd ..
lessy$
lessy$ # Finally, restart the Rails server
lessy$ screen bundle exec rails s -p 3001
lessy$ <ctrl+a><d>
```

## Documentation credits

It's always painful to write documentation, especially when you don't fully
master what you explain :). I want to thank:

- The Diaspora project which is built on Rails as well. [The documentation
  helped me a lot](https://wiki.diasporafoundation.org/Installation)!
- Daniel Loureiro for his blog post on [how to configure Apache with
  Puma](http://www.learnwithdaniel.com/2015/01/apache-puma-via-reverse-proxy/).
- [PostgreSQL documentation](https://wiki.postgresql.org/wiki/Main_Page)
  because I think I would still be trying to make it works.

This documentation is probably not complete and you are welcome to [open a pull
request](https://github.com/marienfressinaud/lessy/pulls) to improve it.
