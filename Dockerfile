FROM ruby:2.6
# Update the Packages
RUN apt-get update
# Install container dependencies, including NodeJS
RUN apt-get install -y wget vim libc-ares2 postgresql-client build-essential nodejs --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
# Install Node / Yarn dependencies
RUN wget -qO- https://deb.nodesource.com/setup_13.x  | bash - && \
  apt-get install -y nodejs && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn && apt-get clean
# Install VIM to edit credentials.yml.enc file
ENV EDITOR="vim --wait"
# Set the work directory inside container
RUN mkdir /app
WORKDIR /app
# Copy the Gemfile inside the container
COPY Gemfile* /app/
# Install dependencies
RUN gem install bundler -v '2.1.4'
RUN bundle install --jobs 32 --retry 4
# Copy all the rest inside work directory
COPY . /app
