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

FROM gcr.io/distroless/base:latest as base
WORKDIR /app
COPY --from=download /download/go-pr-release ./
COPY --from=download /etc/ssl/certs /etc/ssl/certs
CMD ["/app/go-pr-release"]
