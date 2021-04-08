FROM golang:1.16-alpine3.12 AS go-compiler
RUN apk add --no-cache git && rm -rf /tmp/*
ENV GOPATH /go
RUN go get -u github.com/k6io/k6

FROM node:14.16-alpine3.12 as api-testing
LABEL REPO="https://github.com/dronedeploy/load-testing"

RUN apk add --no-cache bash && rm -rf /tmp/*
COPY --from=go-compiler /go/bin/k6 /usr/local/bin/

WORKDIR /api-testing

CMD [ "bash" ]

ARG GIT_HASH
LABEL GIT_HASH=${GIT_HASH}
ENV GIT_HASH=${GIT_HASH}
