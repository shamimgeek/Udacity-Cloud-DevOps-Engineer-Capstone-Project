FROM golang:alpine3.12 AS builder

LABEL Maintainer="shamim.rhce@gmail.com"

WORKDIR /go/src/app

COPY ./app/main.go /go/src/app

RUN go build -o webserver .

FROM alpine:edge
WORKDIR /app
COPY --from=builder /go/src/app/ /app/
COPY ./app/index.html /app/
EXPOSE 80

CMD [ "./webserver" ]