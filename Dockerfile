FROM alpine:3.24.3

# hadolint ignore=DL3018
RUN apk --no-cache add bash grep sed netcat-openbsd

COPY entrypoint /entrypoint

ENTRYPOINT ["/entrypoint"]
