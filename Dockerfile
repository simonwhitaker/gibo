FROM alpine

# install requirements
RUN apk --no-cache --update add \
      ca-certificates \
      git \
      openssh-client \
      && \
      rm -rf /var/lib/apt/lists/* && \
      rm -rf /var/cache/apk/*

RUN git clone https://github.com/github/gitignore.git /root/.gitignore-boilerplates
COPY gibo gibo

ENTRYPOINT ["./gibo"]
