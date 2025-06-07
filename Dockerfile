# syntax=docker/dockerfile:1

FROM golang:1.23.10-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /gibo

FROM alpine:3.18.2

WORKDIR /

COPY --from=build /gibo /gibo
RUN /gibo update

ENTRYPOINT [ "/gibo" ]
