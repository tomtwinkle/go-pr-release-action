FROM ubuntu:latest as download

WORKDIR /download
RUN apt-get update && \
    apt-get install --assume-yes --no-install-recommends curl jq ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*

RUN curl https://api.github.com/repos/tomtwinkle/go-pr-release/releases/latest | \
    jq '.assets[] | select(.name | contains("linux_amd64")) | .browser_download_url' | \
    xargs curl -L | \
    tar -xz

FROM ubuntu:latest as base
WORKDIR /app
RUN apt-get update && \
    apt-get install --assume-yes --no-install-recommends ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*
COPY --from=download /download/go-pr-release ./
CMD ["/app/go-pr-release"]
