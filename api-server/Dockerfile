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

COPY . /opt/gauntlt-server
COPY --from=0 /usr/bin/nmap /usr/bin/nmap

WORKDIR /opt/gauntlt-server
RUN gem install bundler \
  && bundle install

EXPOSE 5000
CMD ["ruby", "app.rb"]
