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
- Redis is used as message broker to keep backend in sync with frontend
- emails must be sent through a SMTP server

For the rest, we let you find information in `Dockerfile` and in the next
sections of this document.

## Configure Docker and docker-compose

You must have Docker running on your computer. To learn how to install Docker,
please refer to [the official documentation](https://docs.docker.com/engine/installation/).

Then, make sure you have docker-compose installed. It will orchestrate required
services (i.e. database, message broker and application for the moment). Have a
look to [their documentation](https://docs.docker.com/compose/install/) to
install it.

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
way (it is just a bit easier to document ;)). Also please note you absolutely
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

## Install Redis server

We now need to deploy Redis which is used to send async messages from backend
to frontend.

Let's create a `docker-compose` file:

```console
# mkdir -p /opt/redis && cd /opt/redis
# vim docker-compose.yml

version: '3'

services:
  redis:
    image: redis:4.0-alpine
    restart: always
    ports:
      - "6379:6379"
    network_mode: bridge
```

Then, create a systemd unit file:

```console
# vim /etc/systemd/system/redis.service

[Unit]
Description=Redis service
After=network.target docker.service

[Service]
Type=simple
WorkingDirectory=/opt/redis
ExecStart=/usr/local/bin/docker-compose -f /opt/redis/docker-compose.yml up
ExecStop=/usr/local/bin/docker-compose -f /opt/redis/docker-compose.yml down
TimeOutSec=300

[Install]
WantedBy=multi-user.target
```

Now, you can start Redis:

```
# systemctl start redis
# systemctl enable redis
```

You should now see a running container named `redis_redis_1` when typing
`docker ps`.

## Install Lessy service

Since it doesn't exist one configuration for production, we do not provide a
`docker-compose-prod.yml` file. However, we give you here a basic layout and
explanations to adapt it to your situation.

```console
# mkdir -p /opt/lessy && cd /opt/lessy
# vim docker-compose.yml

version: '3'

services:
  lessy:
    image: lessy/lessy:latest
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
      REDIS_HOST: redis
      REDIS_PORT: 6379
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
(see `docker-compose-dev.yml` file at the [root of Lessy repository](https://github.com/lessy-community/lessy)).

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

Lessy will take a bit of time to start because docker-compose needs to download
the image first. After few seconds depending on your connection, you should
have a running `lessy_lessy_1` container listening on port 3000.

Now, you must initialize your database schema:

```console
$ docker-compose run --rm lessy bundle exec rails db:schema:load
```

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

  location /cable {
    proxy_pass http://127.0.0.1:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";

    # Uncomment if you use https
    # proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    # proxy_set_header Host $http_host;
    # proxy_set_header X-Real-IP $remote_addr;
    # proxy_set_header X-Forwarded-Proto https;
    # proxy_redirect off;
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
tracker](https://github.com/lessy-community/lessy/issues) and open an issue,
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

## Make your user admin

Once you'll have created your first account, you might be interested to give it
admin permissions:

```console
$ docker-compose run --rm lessy bundle exec rails console
> user = User.first
> # Make sure it is your user!
> user.update admin: true
```

You should now be able to login at `https://your.lessy.server/admin`.

## Configure user registration

By default, public registration for user is disabled. If you want to enable it,
run:

```console
$ docker-compose run --rm lessy bundle exec rails console
irb> Flipper.enable :feature_registration
irb> # or if you want to disable it again
irb> Flipper.disable :feature_registration
```

You might want to set up some rules for your future users. Terms of service are
the perfect way to do it. You can create them in the administration. Content
accepts HTML. Terms of service are effective once the "effective date" (i.e.
`effective_at`) is passed. Versions must be unique.

## Updating Lessy

For each version of Lessy, you may have to perform a certain number of steps.
We'll try to be as exhaustive as possible!

First of all, always check for "Migration notes" [in the CHANGELOG](https://github.com/lessy-community/lessy/blob/master/CHANGELOG.md).
We try to automate most of the steps, but you might need to add/rename
environment variables or install new service.

Then, get the latest image up to date:

```console
$ docker pull lessy/lessy:latest
```

Finally, we need to apply last migrations to the database (if any) and restart
the service:

```console
$ docker-compose run --rm lessy bundle exec rails db:migrate
$ systemctl restart lessy
```
