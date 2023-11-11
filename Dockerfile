FROM golang:1.21 AS build

WORKDIR /go/src/app
COPY ./catgpt/go.mod ./catgpt/go.sum  ./

RUN go mod download

COPY ./catgpt/ ./

RUN CGO_ENABLED=0 GOARCH=amd64  go build -o /go/bin/app

FROM gcr.io/distroless/static-debian12:latest-amd64

COPY --from=build /go/bin/app /

EXPOSE 8080 9090
CMD ["/app"]