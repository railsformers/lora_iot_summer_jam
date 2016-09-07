FROM jeniceek/debian-ruby

ENV dir /usr/src/app

RUN mkdir -p ${dir}
WORKDIR ${dir}

COPY . ${dir}

RUN gem install bundler && bundle install
