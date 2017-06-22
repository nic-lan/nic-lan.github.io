FROM niclan/phoenix-base-no-ecto

RUN git clone https://github.com/nic-lan/nic-lan.github.io.git /app

WORKDIR /app

RUN yes | mix deps.get

RUN brunch build

RUN mix compile

CMD mix phoenix.server
