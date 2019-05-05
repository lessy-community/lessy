FROM ruby:2.4-alpine
MAINTAINER Marien Fressinaud <dev@marienfressinaud.fr>

EXPOSE 3000 5000

WORKDIR /app/

RUN apk add --no-cache \
      nodejs \
      nodejs-npm \
      postgresql-client \
      tzdata
RUN apk --update add --virtual build-dependencies \
      build-base \
      ruby-dev \
      postgresql-dev \
      libc-dev \
      linux-headers \
      cmake \
      gmp-dev

RUN gem install bundler

COPY Gemfile Gemfile.lock /app/
COPY client/package.json client/package-lock.json /app/client/

VOLUME /app

CMD ["bundle", "exec", "foreman", "start"]
