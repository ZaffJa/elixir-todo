FROM elixir:1.6

COPY . /app

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

RUN mix local.hex --force \
    && mix archive.install hex phx_new 1.4.1 \
    && apt-get update \
    # Install NodeJS
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y apt-utils \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && apt-get install -y inotify-tools \
    && mix local.rebar --force

CMD ["mix", "phx.server"]
