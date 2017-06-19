FROM niclan/phoenix-base-no-ecto

RUN git clone https://github.com/nic-lan/nic-lan.github.io.git /app

WORKDIR /app

RUN git checkout secure-webhooking

RUN yes | mix deps.get

RUN brunch build

RUN mix compile

RUN mix espec

RUN

EXPOSE 80

CMD PORT=80 mix phoenix.server
