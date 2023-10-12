FROM ruby:3.1.2

RUN apt-get update && apt-get install -y \
  software-properties-common \
  postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash
RUN apt-get update && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile* .
COPY package* .

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]