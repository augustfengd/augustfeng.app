FROM rust:1.67 as builder
WORKDIR /usr/src/domain
COPY . .
RUN cargo install --path .

FROM debian:bullseye-slim
COPY --from=builder /usr/local/cargo/bin/domain /usr/local/bin/domain
CMD ["domain"]