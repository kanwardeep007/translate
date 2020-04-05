FROM ruby:2.4.10-alpine

RUN apk --update add build-base nodejs tzdata libxslt-dev libxml2-dev imagemagick curl bash sqlite-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN gem install bundler
RUN bundle install
COPY . /usr/src/app

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-e", "development", "-b", "0.0.0.0"]