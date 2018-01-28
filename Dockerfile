FROM ubuntu:14.04

RUN apt-get update && \
    apt-get -yq install curl software-properties-common python-software-properties && \
    add-apt-repository -y ppa:ethereum/ethereum
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    apt-get install -y nodejs
RUN apt-get update && \
    apt-get -yq install ethereum

WORKDIR /usr/src/app

EXPOSE 8545 30303

COPY . .

RUN geth --datadir . init genesis.json

RUN geth --datadir . account import key.prv --password password.sec || true

CMD ./startnode.sh
