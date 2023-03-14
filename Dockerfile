FROM debian:bullseye-slim as download
WORKDIR /download
RUN apt-get update && \
    apt-get install --assume-yes --no-install-recommends curl jq ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*
RUN curl -s -L https://github.com/tomtwinkle/go-pr-release/releases/latest/download/go-pr-release_linux_x86_64.tar.gz | \
    tar -xvz

FROM gcr.io/distroless/base:latest as base
WORKDIR /app
COPY --from=download /download/go-pr-release ./
COPY --from=download /etc/ssl/certs /etc/ssl/certs
CMD ["/app/go-pr-release"]
