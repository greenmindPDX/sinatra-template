# Start with our lightweight Alpine linux image + Oracle's JRE
FROM pdxdan/hsq-alpine-java:8_92
MAINTAINER HealthSparqOne Team <DL-HSOne@regence.com>

# Install latest Ruby and Gem dependencies
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update
RUN apk add bash curl tar
RUN apk add gcc gnupg procps musl-dev make linux-headers \
        zlib zlib-dev openssl openssl-dev libssl1.0
RUN apk add postgresql
RUN apk add jruby
RUN jruby -S gem install bundler


ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN cd $APP_HOME
COPY Gemfile* $APP_HOME/


# Install and run bundler

RUN jruby -S bundle install

# Copy the Sinatra application into place
COPY . $APP_HOME

# Start server
ENV PORT 3000
EXPOSE 3000

# Start the application
#CMD ["bundle", "exec", "jruby", "app.rb"]
CMD jruby -S bundle exec jruby app.rb