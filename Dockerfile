FROM elixir:1.2

RUN apt-get update -qq
RUN yes | apt-get install build-essential jq

WORKDIR /app
COPY . /app

COPY mix.exs mix.exs
COPY mix.lock mix.lock

RUN yes | mix deps.get

RUN mix compile

EXPOSE 4000

CMD PORT=$PORT mix phoenix.server
