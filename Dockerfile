# Start with our lightweight Alpine linux image + Oracle's JRE
FROM pdxdan/hsq-alpine-java:8_92
MAINTAINER HealthSparqOne Team <DL-HSOne@regence.com>

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Install latest Ruby and Gem dependencies
RUN apk update
RUN apk add bash curl tar
RUN apk add gcc gnupg procps musl-dev make linux-headers \
        zlib zlib-dev openssl openssl-dev libssl1.0
RUN apk add postgresql

ENV RVM_USER    rvm
ENV RVM_GROUP   rvm
ENV SU_RVM      su - $RVM_USER -c

# User
RUN addgroup $RVM_GROUP && \
    adduser -h /home/$RVM_USER -g 'RVM User' -s /bin/bash -G $RVM_GROUP -D $RVM_USER

# Download and Build
RUN $SU_RVM 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
             curl -L -o stable.tar.gz https://github.com/rvm/rvm/archive/stable.tar.gz && \
             gunzip -c stable.tar.gz | tar xf - && \
             cd rvm-stable && ./scripts/install'
RUN $SU_RVM './.rvm/bin/rvm install jruby-9.1.6.0 --autolibs=0'
RUN $SU_RVM './.rvm/bin/rvm alias create default jruby-9.1.6.0'
RUN $SU_RVM './.rvm/bin/rvm use jruby'

#ENV RUBY_HOME /home/rvm/.rvm/rubies/jruby-9.1.6.0/bin/jruby

# /home/rvm/.rvm/gems/jruby-9.1.6.0/bin/bundle not found

# ENV PATH /usr/local/rvm/gems/ruby-1.9.3-p448/bin:$PATH
# export PATH=/var/lib/gems/1.8/bin/:${PATH}

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN cd $APP_HOME
COPY Gemfile* $APP_HOME/


# Install and run bundler
#RUN jruby -S gem install bundler

#RUN $GEM_HOME/bundle install

# Copy the Sinatra application into place
COPY . $APP_HOME

# Start server
ENV PORT 3000
EXPOSE 3000

# Start the application
#CMD ["bundle", "exec", "jruby", "app.rb"]
CMD ["ls"]
