# syntax=docker/dockerfile:1

FROM golang:1.20.6-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /gibo-go

FROM alpine:3.18.2

WORKDIR /

COPY --from=build /gibo-go /gibo-go
RUN /gibo-go update

ENTRYPOINT [ "/gibo-go" ]
