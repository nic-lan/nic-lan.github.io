FROM niclan/phoenix-base-no-ecto:latest

COPY . /app

WORKDIR /app

RUN yes | mix deps.get

RUN brunch build

RUN yes | mix compile

CMD mix phoenix.server
