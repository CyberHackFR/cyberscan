####################################################################################################
## Build cyberscan
####################################################################################################
FROM rust:latest AS builder_rust

RUN rustup update
RUN rustup target add x86_64-unknown-linux-musl
RUN apt update && apt install -y musl-tools musl-dev libssl-dev
RUN update-ca-certificates

# Create appuser
ENV USER=cyberscan
ENV UID=10001

# See https://stackoverflow.com/a/55757473/12429735RUN
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"


WORKDIR /cyberscan

COPY ./ .
WORKDIR /cyberscan/cyberscan

RUN make build_static
# RUN make build


####################################################################################################
## Final image
####################################################################################################
# FROM scratch
# Here we prefer alpine because otherwise the container won't launch on heroku
FROM alpine:latest

RUN apk update && apk add --no-cache ca-certificates
RUN update-ca-certificates

# Import from builder.
COPY --from=builder_rust /etc/passwd /etc/passwd
COPY --from=builder_rust /etc/group /etc/group

WORKDIR /cyberscan
ENV PATH="/cyberscan:${PATH}"

# Copy our builds
COPY --from=builder_rust /cyberscan/cyberscan/dist/ ./

# Use an unprivileged user.
USER cyberscan:cyberscan

CMD ["/cyberscan/cyberscan", "--help"]

LABEL maintainer="CyberHack <https://www.cyberhack.fr>"
LABEL homepage=https://github.com/CyberHackFR/cyberscan
LABEL org.opencontainers.image.name=cyberscan
LABEL repository=https://github.com/CyberHackFR/cyberscan
LABEL org.opencontainers.image.source https://github.com/CyberHackFR/cyberscan
