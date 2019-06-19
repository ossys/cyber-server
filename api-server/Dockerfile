FROM ruby:2.6.3-stretch
MAINTAINER Andrew Zah <andrew.zah@ossys.com>

COPY . /opt/gauntlt-server

WORKDIR /opt/gauntlt-server
RUN gem install bundler \
  && bundle install

EXPOSE 5000
CMD ["ruby", "app.rb"]
