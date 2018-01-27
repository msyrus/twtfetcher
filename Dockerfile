FROM golang:alpine
RUN apk add --no-cache --update git
ENV GOPATH=/go

RUN go get -u github.com/golang/dep/cmd/dep
COPY . $GOPATH/src/github.com/msyrus/twtfetcher
WORKDIR $GOPATH/src/github.com/msyrus/twtfetcher
RUN ./build.sh

FROM alpine:latest
RUN apk add --no-cache --update ca-certificates openssl
COPY --from=0 /go/bin/twtfetcher /usr/local/bin/twtfetcher

ENTRYPOINT ["twtfetcher"]
