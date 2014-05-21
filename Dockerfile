# bitcoin-testnet-box docker image
#
# This image uses an "easy-mining" branch of bitcoind to make new blocks occur 
# more frequently while mining with `make generate-true`
#

FROM ubuntu:12.04
MAINTAINER Jud Stephenson <j@nybex.com>

RUN apt-get update -qq
RUN apt-get install python-software-properties -qq -y
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update -qq
RUN apt-get install bitcoind make -y -qq

# create a non-root user
RUN adduser --disabled-login --gecos "" bitcoin

# run following commands from user's home directory
WORKDIR /home/bitcoin

# copy the testnet-box files into the image
ADD . /home/bitcoin/bitcoin-testnet-box

# make tester user own the bitcoin-testnet-box
RUN chown -R bitcoin:bitcoin /home/bitcoin/bitcoin-testnet-box

# use the tester user when running the image
USER bitcoin

# run commands from inside the testnet-box directory
WORKDIR /home/bitcoin/bitcoin-testnet-box

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19000 19001

CMD ["/bin/bash"]
