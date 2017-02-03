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

# Install and run jruby and bundler
RUN apk add jruby
RUN jruby -S gem install bundler

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN cd $APP_HOME
COPY Gemfile* $APP_HOME/
RUN jruby -S bundle install

# Alterations for postgresql tweaks
COPY postgresql/conf/postgresql.conf /var/lib/postgresql/data/postgresql.conf
COPY postgresql/conf/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf
USE postgres
#CMD ["/usr/lib/postgresql/9.2/bin/postgres", "-D"]

USER root
# Copy the Sinatra application into place
COPY . $APP_HOME

# Expose the PostgreSQL port
EXPOSE 5432
# Start server
ENV PORT 3000
EXPOSE 3000

# Start the application
#CMD ["bundle", "exec", "jruby", "app.rb"]
CMD jruby -S bundle exec jruby app.rb
