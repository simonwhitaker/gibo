FROM alpine

# install requirements
RUN apk --no-cache --update add git \
      && git clone https://github.com/github/gitignore.git /root/.gitignore-boilerplates
COPY gibo gibo

ENTRYPOINT ["./gibo"]
