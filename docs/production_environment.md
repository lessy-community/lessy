# Install Lessy for production

First, you should know that a Lessy instance is running at https://lessy.io,
you don't necessarily need to install it by yourself!

Then, it exists a lot of way to deploy Lessy in production and we can't cover
all of them. This document explains a technique based on Docker and Nginx for
Debian 9.

## Don't want to use Docker?

Ok, that's fine! But there is no official documentation to help you. All we can
do for the moment is to explain global stack:

- backend is run on top of Ruby on Rails
- frontend is built with VueJS and you'll need Node and NPM to compile it
- database must be PostgreSQL
- emails must be sent through a SMTP server (that's the main difference with
  development environment!)

For the rest, we let you find information in `Dockerfile.prod` and in the next
sections of this document.

## Configure Docker and docker-compose

You must have Docker running on your computer. To learn how to install Docker,
please refer to [the official documentation](https://docs.docker.com/engine/installation/).

Then, make sure you have docker-compose installed. It will orchestrate required
services (i.e. database and application for the moment). Have a look to [their
documentation](https://docs.docker.com/compose/install/) to install it.

## Install SMTP server

You should install Postfix server so emails can be sent to users. Here, we
install it via `apt-get` because we didn't find any good and simple image based
on Docker.

```console
# apt-get install postfix
```

Since we will send emails via port 25 (no authentication), we must allow
emails to be sent through the default Docker network:

```console
# vim /etc/postfix/main.cf

...
# Add 172.17.0.0/16 network to mynetworks
mynetworks = 127.0.0.0/8 [::1]/128 172.17.0.0/16
...
```

Then, you need to enable/start Postfix:

```console
# systemctl start postfix
# systemctl enable postfix
```

## Install PostgreSQL server

Here, we deploy PostgreSQL with Docker. You also can do it with `apt-get` but
we will not explain it!

First, we need to can create a very simple `docker-compose` file:

```console
# mkdir -p /opt/postgresql && cd /opt/postgresql
# vim docker-compose.yml

version: '3'

services:
  db:
    image: postgres:9.6-alpine
    environment:
      POSTGRES_USER: <postgres_user>
      POSTGRES_PASSWORD: <postgres_password>
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    network_mode: bridge

volumes:
  postgres_data:
```

`network_mode: bridge` connects our container to the default Docker network so
it is accessible by other services but you don't necessarily need to do it this
way (it is just a bit easier to document ;)). Also please not you absolutly
need to create a named volume for data if you don't want to loose them at the
next restart!

Then, create a systemd unit file:

```console
# vim /etc/systemd/system/postgresql.service

[Unit]
Description=PostreSQL service
After=network.target docker.service

[Service]
Type=simple
WorkingDirectory=/opt/postgresql
ExecStart=/usr/local/bin/docker-compose -f /opt/postgresql/docker-compose.yml up
ExecStop=/usr/local/bin/docker-compose -f /opt/postgresql/docker-compose.yml down
TimeOutSec=300

[Install]
WantedBy=multi-user.target
```

Now, you can start your database:

```
# systemctl start postgresql
# systemctl enable postgresql
```

You should now see a running container named `postgresql_db_1` when typing
`docker ps`.

## Install Lessy service

Since it doesn't exist one configuration for production, we do not provide a
`docker-compose-prod.yml` file. However, we give you here a basic layout and
explanations to adapt it to your situation.

```console
# mkdir -p /opt/lessy && cd /opt/lessy
# git clone git@github.com:marienfressinaud/lessy.git code
# vim docker-compose.yml

version: '3'

services:
  lessy:
    image: lessy:prod
    build:
      context: code
      dockerfile: Dockerfile.prod
    external_links:
      - postgresql_db_1:db
    ports:
      - "3000:3000"
    environment:
      DATABASE_NAME: lessy_production
      DATABASE_USERNAME: <postgres_user>
      DATABASE_PASSWORD: <postgres_password>
      DATABASE_PORT: 5432
      DATABASE_HOST: db
      LESSY_HOST: <server_name>
      LESSY_HTTPS: "true"
      SECRET_KEY_BASE: <secret_key_base>
      SMTP_SERVER: 172.17.0.1
      SMTP_PORT: 25
      SMTP_OPENSSL_VERIFY_MODE: none
    network_mode: bridge
```

`DATABASE_*` variables need obviously to match with configuration of
PostgreSQL. Both services are connected through the `external_links`
instruction. If you need PostgreSQL for Lessy only, you can put both services
in the same file and the connection would be done through a `links` instruction
(see `docker-compose-dev.yml` file at the [root of Lessy repository](https://github.com/marienfressinaud/lessy)).

If you don't have a SSL certificate, just remove `LESSY_HTTPS` variable (but
you really should!)

`secret_key_base` can be generated with `rails secret` or with a simple Ruby
command:

```console
$ irb
> require 'securerandom'
> puts SecureRandom.hex(64)
```

Here, `network_mode: bridge` is required so Lessy can access Postfix installed
on the host. `172.17.0.1` corresponds to the Docker container's gateway which
is the host.

Now, we need a systemd unit file:

```console
# vim /etc/systemd/system/lessy.service
[Unit]
Description=Lessy service
After=network.target docker.service

[Service]
Type=simple
WorkingDirectory=/opt/lessy
ExecStart=/usr/local/bin/docker-compose -f /opt/lessy/docker-compose.yml up
ExecStop=/usr/local/bin/docker-compose -f /opt/lessy/docker-compose.yml down

[Install]
WantedBy=multi-user.target
```

And start the service:

```console
# systemctl start lessy
# systemctl enable lessy
```

Lessy will take a bit of time to start because docker-compose needs to build
the image first (install dependencies and compile frontend). After few minutes,
you should have a running `lessy_lessy_1` container listening on port 3000.

## Configuring Nginx

The final step is to configure Nginx so it redirects requests from port 80 to
port 3000.

If it's not done yet, install Nginx with:

```console
# apt-get install nginx
```

Then, create a configuration file:

```console
# vim /etc/nginx/sites-available/<server_name>.conf
server {
  listen 80;
  listen [::]:80;
  server_name <server_name>;

  location / {
    proxy_pass http://127.0.0.1:3000;
  }

  error_log /var/log/nginx/<server_name>_error.log;
  access_log /var/log/nginx/<server_name>_access.log;
}
```

And link it as a an enabled site:

```console
# ln -s /etc/nginx/sites-available/<server_name>.conf /etc/nginx/sites-enabled/<server_name>.conf
```

Start or reload Nginx:

```console
# systemctl start nginx  # OR systemctl reload nginx
# systemctl enable nginx  # if not done yet
```

You should now be able to access Lessy. If it's working, well done, that was
not so easy! :) If you encounter any problem, please [meet us on our bug
tracker](https://github.com/marienfressinaud/lessy/issues) and open an issue,
we'll try to help you and improve this documentation as well.

## Configuring HTTPS

Today, there is no more excuses to not configuring HTTPS, especially when
manipulating personal data. Let's configure it with [Let's Encrypt](https://letsencrypt.org/):

```console
# apt-get install certbot python-certbot-nginx
# certbot --nginx -d <server_name> --email <your_email>
```

You'll need to agree to terms of service and say if you want to force HTTPS
(highly recommended!)

## Updating Lessy

For each version of Lessy, you may have to perform a certain number of steps.
We'll try to be as exhaustive as possible!

First of all, always check for "Migration notes" [in the CHANGELOG](https://github.com/marienfressinaud/lessy/blob/master/CHANGELOG.md).
We try to automate most of the steps, but you might need to add/rename
environment variables or install new service.

Then, get the source code up to date:

```console
$ cd /opt/lessy/code
$ git pull
```

If `git pull` fails, it probably means you changed something here… You should
not unless you really know what you do! You can try to execute this commands
instead:

```console
$ git stash
$ git pull
$ git stash pop
```

If you are in this case, please [open an issue](https://github.com/marienfressinaud/lessy/issues)
so we can figure out how to make it simpler for you.

Then, we'll rebuild our image:

```console
$ cd /opt/lessy
$ docker-compose build
```

It will take a bit of time but it should succeed!

Finally, we need to apply last migrations to the database (if any) and restart
the service:

```console
$ docker-compose run --rm lessy bundle exec rails db:migrate
$ systemctl restart lessy
```
