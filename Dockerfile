From ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

MAINTAINER Arnaud Boré <arnaud.bore@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install wget build-essential cmake git pigz \
               nodejs python3 python3-pip unzip

RUN pip3 install dcm2bids

# Install dcm2niix from github
ENV DCM2NIIX_VERSION="v1.0.20211006"
COPY dcm2niix /usr/bin
RUN chmod 777 /usr/bin/dcm2niix

WORKDIR /