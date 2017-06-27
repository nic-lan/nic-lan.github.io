FROM niclan/phoenix-base-no-ecto:latest

COPY . /app

WORKDIR /app

RUN yes | mix deps.get

RUN brunch build

RUN MIX_ENV=prod mix compile

CMD MIX_ENV=prod mix phoenix.server
