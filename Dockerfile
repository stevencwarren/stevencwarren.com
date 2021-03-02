FROM elixir:1.11.3
RUN apt-get update -qq && apt-get install -y postgresql-client inotify-tools apt-utils

# Installing node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . /app

RUN mix deps.get
RUN cd assets && \
  npm install && \
  cd /app

# Add a script to be executed every time the container starts.
EXPOSE 4000

# Start the main process.
CMD [mix, phx.server]

