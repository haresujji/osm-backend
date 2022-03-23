FROM ruby:2.6.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y vim
RUN apt-get install -y tzdata
RUN apt-get install -y yarn
RUN mkdir /osm_backend
WORKDIR /osm_backend
COPY Gemfile* /osm_backend/
RUN gem install bundler
RUN bundle install --full-index
RUN bundle update rails

COPY . /osm_backend

# Add a script to be executed every time the container starts.
EXPOSE 32412

# Start the main process.
#CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]


CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

