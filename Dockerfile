FROM ruby:2.7.2

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update
RUN apt-get install -y nodejs yarn redis-server vim screen

ARG environment
ENV APP_HOME /app
# Adding this env variable to hide depreceation messages when running app
ENV RUBYOPT='-W:no-deprecated'
RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}

RUN gem install bundler:2.1.4
COPY Gemfile* ${APP_HOME}/
RUN bundle install
COPY . ${APP_HOME}
RUN if [ "$environment" = "production" ] ; then RAILS_ENV=production rails assets:precompile ; fi
RUN yarn cache clean && yarn install --check-files
CMD ["rails", "server", "-b", "0.0.0.0"]
