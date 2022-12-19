FROM golang:1.18-alpine as builder

USER root

RUN     \
        set -eux \
&&      apk add --update --no-cache --no-progress --upgrade -X http://dl-cdn.alpinelinux.org/alpine/edge/testing git \
&&      mkdir -p /root/gocode \
&&      export GOPATH=/root/gocode \
&&      go install github.com/mailhog/MailHog@latest

FROM	scratch

COPY 	--from=builder / /

WORKDIR /home/vairogs

ENTRYPOINT ["MailHog"]

USER 	vairogs

EXPOSE 	1025 
EXPOSE  8025

