FROM ubuntu:20.04
LABEL maintainer="yantene <contact@yantene.net>"

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt update && \
  apt install -y curl make gcc g++ file flex libasound2-dev libreadline6-dev

RUN \
  tmpdir=`mktemp -d` && \
  cd ${tmpdir} && \
  curl -L -O 'https://downloads.sourceforge.net/project/takt/takt-0.310-src.tar.gz' && \
  tar xf takt-0.310-src.tar.gz && \
  cd takt-0.310 && \
  ./configure && \
  make && \
  make install && \
  rm -rf ${tmpdir}

RUN \
  apt autoremove -y curl make gcc g++ file flex && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/takt"]
