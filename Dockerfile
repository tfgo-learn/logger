FROM golang:1.9.1-alpine as builder

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
                git \
	; \
	go get -u github.com/golang/dep/cmd/dep \
	; \
        apk del .build-deps

FROM golang:1.9.1-alpine

RUN set -eux; \
	apk add --no-cache git

COPY --from=builder /go/bin/ /go/bin/
