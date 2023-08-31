FROM ubuntu:lunar

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update -y
RUN apt-get -q install -y orthanc

EXPOSE 11112
EXPOSE 8042

ARG TARGETARCH

RUN mkdir -p /images

RUN mkdir -p /root/src
WORKDIR /root/src

# Indexer plugin to sync with the caMicroscope folder
COPY build_orthanc_indexer.sh .
RUN chmod a+x build_orthanc_indexer.sh
RUN ./build_orthanc_indexer.sh
RUN chmod a+x libOrthancIndexer.so

# TODO? orthanc-dicomweb ubuntu apt package?

COPY . .

# https://book.orthanc-server.com/users/docker.html
ENV MALLOC_ARENA_MAX 5

# --verbose-plugins
CMD Orthanc --verbose-plugins /root/src/Configuration.json
