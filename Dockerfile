FROM node:14.16-alpine3.13 as api-tester
LABEL REPO="https://github.com/dronedeploy/api-testing"

RUN apk add --no-cache bash gzip tar wget && rm -rf /tmp/*

WORKDIR /tmp
ARG K6_VERSION=v0.31.1
RUN wget --quiet https://github.com/k6io/k6/releases/download/${K6_VERSION}/k6-${K6_VERSION}-linux64.tar.gz && \
    tar xvzf k6-${K6_VERSION}-linux64.tar.gz && mv k6-${K6_VERSION}-linux64/k6 /usr/local/bin && rm -rf k6-${K6_VERSION}-linux64*

WORKDIR /api-tester
CMD [ "bash" ]

ARG GIT_HASH
LABEL GIT_HASH=${GIT_HASH}
ENV GIT_HASH=${GIT_HASH}
