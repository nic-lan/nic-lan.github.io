FROM elixir:1.4

RUN apt-get update -qq

RUN apt-get install -y build-essential jq git-all

RUN apt-get -y install libssl-dev

# to install brunch
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs

COPY . /app

WORKDIR /app

RUN npm install -g brunch

RUN brunch build

RUN mix local.rebar --force

RUN mix local.hex --force

RUN yes | mix deps.get

RUN MIX_ENV=prod mix compile

CMD MIX_ENV=prod mix phoenix.server
