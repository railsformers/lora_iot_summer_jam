# IoT Summer Jam

Load and processing of data from `api.pripoj.me`.

<!-- ## Run from docker
```
docker-compose up
```
Then type `http://localhost:3000` to your browser. -->

## System dependency

For installation and startup you need to have installed the following technologies:

```
Linux distribution
Ruby 2.1 and later - https://www.ruby-lang.org/en/downloads/
nodejs - https://nodejs.org/en/
```

## Installation

Install all dependencies is done through the following commands:

```
bin/bundle install
```

Database creation and initialization scheme:
```
sudo -u postgres -- createuser -d lora_api -P
cp config/database.yml.sample config/database.yml
Edit the file `config/database.yml` to suit your needs

bin/bundle exec rake db:create
bin/bundle exec rake db:migrate
```

Application config:
```
cp config/application.yml.example config/application.yml
Edit the file `config/application.yml` to suit your needs
```

## Running an application in developer mode
```
bin/bundle exec rails s
```

After you run the previous command, visit the web presentation here:
```
http://localhost:3000
```

## Running tests
```
bin/bundle exec rspec
```
