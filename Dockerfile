FROM niclan/phoenix-base-no-ecto:latest

COPY . /app

WORKDIR /app

RUN yes | mix deps.get --only prod

RUN MIX_ENV=prod mix compile

RUN brunch build

RUN MIX_ENV=prod mix phoenix.digest

CMD MIX_ENV=prod mix phoenix.server
