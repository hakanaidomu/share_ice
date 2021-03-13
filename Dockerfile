FROM ruby:2.6.5
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /share_ice

ADD Gemfile /share_ice/Gemfile
ADD Gemfile.lock /share_ice/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /share_ice