FROM ruby:2.4-alpine
MAINTAINER Marien Fressinaud <dev@marienfressinaud.fr>

EXPOSE 3000

WORKDIR /app/
COPY Gemfile Gemfile.lock /app/
COPY client/package.json client/package-lock.json /app/client/

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

RUN apk add --no-cache \
      nodejs \
      postgresql-client \
      tzdata \
  && npm install npm@5 -g \
  && apk --update add --virtual build-dependencies \
      build-base \
      ruby-dev \
      openssl-dev \
      postgresql-dev \
      libc-dev \
      linux-headers \
      cmake \
      gmp-dev \
  && gem install bundler \
  && bundle install --without test development \
  && apk del build-dependencies

COPY . /app

RUN cd /app/client \
  && npm install \
  && npm cache clean --force \
  && npm run build \
  && rm -rf /app/client/node_modules

CMD ["bundle", "exec", "rails", "server", "-p", "3000"]
