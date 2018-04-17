FROM golang:1.10
MAINTAINER Vadim Chernov <dimuls@yandex.ru>

WORKDIR /go/src/github.com/someanon/rkn-bypasser
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

RUN cp -R ./assets /
RUN rm -rf /go/src

WORKDIR /assets

RUN groupadd -r rkn-bypasser
RUN useradd -r -g rkn-bypasser rkn-bypasser

RUN chown -R rkn-bypasser:rkn-bypasser ./
RUN chmod u+rw ./

EXPOSE 8000
STOPSIGNAL 2

USER rkn-bypasser

ENV ADDR 0.0.0.0:8000

ENTRYPOINT /go/bin/rkn-bypasser run