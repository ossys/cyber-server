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

ENV app /app
RUN mkdir $app
COPY ./Gemfile $app/Gemfile
COPY ./Gemfile.lock $app/Gemfile.lock

COPY --from=0 /usr/bin/nmap /usr/bin/nmap
COPY . $app

WORKDIR $app
ENV BUNDLE_PATH /bundle

RUN gem install bundler \
  && bundle install

#CMD ["sh", "script/start"]
EXPOSE 5000
