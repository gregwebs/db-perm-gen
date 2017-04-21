FROM buildpack-deps:stretch-scm

RUN apt-get update \
 && apt-get install pwgen \
 && apt-get clean

ENV PROGRAM=biscuit-linux_amd64.tgz
RUN wget "https://github.com/dcoker/biscuit/releases/download/v0.1.3/$PROGRAM" \
 && tar -xzvf "$PROGRAM" \
 && rm -f "$PROGRAM" \
 && chmod +x biscuit \
 && mv biscuit /usr/local/bin/biscuit
