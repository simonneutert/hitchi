FROM ruby:2.6.5

RUN \
  apt-get update && \
  apt-get install -y nodejs && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN mkdir /hitchi
WORKDIR /hitchi

COPY GEMFILE* .
RUN bundle check || bundle install

ENV RACK_ENV=production
ENV RAILS_ENV=production

COPY . .

RUN chmod +x start.sh
CMD [ "bash" , "/hitchi/start.sh"]
