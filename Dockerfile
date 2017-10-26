FROM alpine

# install requirements
RUN apk --no-cache --update add \
      ca-certificates  git openssh util-linux && \
      rm -rf /var/lib/apt/lists/* && \
      rm /var/cache/apk/*

RUN git clone https://github.com/github/gitignore.git /root/.gitignore-boilerplates
COPY gibo gibo

ENTRYPOINT ["./gibo"]
