ARG RUBY_VERSION=3.1.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# OS Level Dependencies
RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips \
    curl \
    libmagickwand-dev \
    imagemagick

WORKDIR /app

RUN gem update --system && gem install bundler

COPY Gemfile ./

RUN bundle check || bundle install --jobs 20 --retry 5

COPY . .

RUN chmod +x ./entrypoints/docker-entrypoint.sh 
RUN chmod +x ./entrypoints/sidekiq-entrypoint.sh

# Run migrations
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]