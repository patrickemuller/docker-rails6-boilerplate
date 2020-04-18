# Ordway Labs (test code)

## INSTALLATION

### STANDALONE

#### Dependencies

```
NodeJS
Yarn
bundler
ruby 2.7.0
rails 6.0.0
```

Is the same process for a normal Rails standalone environment:

```shell
$ cp .env.sample .env
$ bin/bundle install
$ bin/rails db:create db:migrate
$ bin/rails s
```

### DOCKER

Some advantages of runningusinng Docker instead of standalone installation:

- Simpler to install
- Simpler to run and get up
- All developers use the same installed packages
- Is Operation System agnostic
- You can mimitize production

First, you need to copy ENV variables, build the container and install dependencies

```shell
$ cp .env.sample .env
$ docker-compose build
```

Then, you can create the Rails' databases

```shell
$ docker-compose run web bin/rails db:create db:migrate
```

Now you can start the services with just one command:

```shell
$ docker-compose up
```

### RUNNING SPECS

#### STANDALONE

```shell
$ bin/rspec
```

#### DOCKER

```shell
$ docker-compose run web bin/rspec
```
