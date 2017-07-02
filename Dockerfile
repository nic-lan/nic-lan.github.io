FROM niclan/phoenix-base-no-ecto:latest

COPY . /app

WORKDIR /app

RUN brunch build

RUN yes | mix deps.get

RUN MIX_ENV=prod mix compile

CMD MIX_ENV=prod mix phoenix.server
