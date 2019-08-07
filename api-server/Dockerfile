FROM debian:stretch
MAINTAINER Andrew Zah <andrew.zah@ossys.com>

# nmap
RUN apt update \
  && apt install -y nmap \
  && rm -rf /var/lib/apt/lists/*

FROM ruby:2.6.3-stretch
MAINTAINER Andrew Zah <andrew.zah@ossys.com>

RUN apt update \
  && apt install -y \
    libpcap-dev \
    liblinear-dev \
    liblua5.3-0 \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV app /app
RUN mkdir -p $app/log
WORKDIR $app

COPY ./Gemfile $app/Gemfile
COPY ./Gemfile.lock $app/Gemfile.lock

ENV BUNDLE_PATH=/bundle \
  BUNDLE_JOBS=3

RUN useradd -ms /bin/bash gauntltuser \
  && mkdir -p $BUNDLE_PATH \
  && chown -R gauntltuser $BUNDLE_PATH

USER gauntltuser
RUN bundle install

COPY --from=0 /usr/bin/nmap /usr/bin/nmap

COPY . $app
USER root
RUN chown -R gauntltuser $app
USER gauntltuser

RUN bundle exec rake app:update:bin \
  && EDITOR=vi bin/rails credentials:edit

EXPOSE 5000
