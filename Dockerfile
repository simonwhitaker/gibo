FROM alpine

COPY gibo gibo

# install requirements
RUN apk --no-cache --update add git && ./gibo update

ENTRYPOINT ["./gibo"]
