FROM ruby:2.6
ENV EDITOR="vim --wait"
# Configure Node & Yarn deb packages
RUN wget -qO- https://deb.nodesource.com/setup_13.x | bash -
RUN wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# Install dependencies
RUN apt-get update
RUN apt-get install -y wget vim libc-ares2 postgresql-client build-essential yarn nodejs --no-install-recommends
RUN apt-get clean
# Install bundler
RUN gem install bundler -v '2.1.4'
# Move files to /app folder
WORKDIR /app
COPY Gemfile* package.json yarn.lock ./
RUN bundle check || bundle install
RUN yarn install
# Copy everything to /app
COPY . ./
