# Deploy Project Zero on your server

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

Even if it is not required, you should create a user dedicated to Project Zero
on your system:

```
root# adduser project-zero
root# chmod 755 /home/project-zero
```

## Install database

Once `postgresql-server` is installed, you should configure it:

```bash
root# postgresql-setup initdb
root# systemctl enable postgresql
root# systemctl start postgresql
```

You should consider to create a new Postgre user as well (note from now, `$`
prompt indicates that you should be connected with `project-zero` user you
created above):

```bash
$ sudo -u postgres psql
postgres=# CREATE USER projectzero WITH CREATEDB PASSWORD '<password>';
```

For more information, please refer to the official [PostgreSQL
documentation](https://wiki.postgresql.org/wiki/First_steps).

## Get Project Zero and configure it

```bash
~$ git clone -b https://github.com/marienfressinaud/project-zero.git
~$ cd project-zero
project-zero$ gem install bundler
project-zero$ RAILS_ENV=production bundle install --deployment --without test development
```

If you face any problem during installation, please open a ticket [on
GitHub](https://github.com/marienfressinaud/project-zero/issues).

It's time to add the required environment variables, in your `~/.bashrc`, add the
following lines and adapt them to your situation:

```
export PROJECTZERO_SMTP_HOST=<your.smtp.server.com>
export DATABASE_URL=postgres://<username>:<password>@localhost:5432/<db name>
export RAILS_ENV=production
export SECRET_KEY_BASE=<your secret key>
```

Note `SECRET_KEY_BASE` can be generated with `bundle exec rails secret`.

Then, run `source ~/.bashrc` to load these variables in your session.

## Setup database

Simply run:

```bash
project-zero$ bundle exec rails db:create db:schema:load
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
project-zero$ cd client
project-zero/client$ npm install
project-zero/client$ npm run build
```

## Serve the application with Apache

Now we need to serve the application by a web server. There are a lot of
possibilities but only one is described here. Advantage is it's very simple.

First, run the application as you would normally, but with `screen`:

```bash
project-zero$ screen bundle exec rails s -p 8081
```

You can leave `screen` by typing `ctrl+a d`. Application is now running in
background, served by `puma` on port 8081.

Last step is to add Apache configuration. For that, you'll need to install
Apache mods `proxy` and `proxy_http` and provide a `VirtualHost` configuration:

```
<VirtualHost *:80>
    ServerAdmin your@emailaddress.com
    DocumentRoot /home/project-zero/project-zero/public
    ServerName your.domain.com

    <Location /static>
        ProxyPass !
    </Location>
    <Directory /home/project-zero/project-zero/public/static>
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

You should now be able to access Project Zero at http://your.domain.com.

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
request](https://github.com/marienfressinaud/project-zero/pulls) to improve it.
