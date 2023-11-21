FROM rust:1.67 as builder

WORKDIR /usr/src/signals

# copy dependency information.

COPY Cargo.toml Cargo.lock ./

# compile as much as we can.

RUN mkdir src && touch src/lib.rs ; cargo build --release

# copy source code

COPY src src/

# complete compilation

RUN cargo build --release

FROM debian:bullseye-slim

RUN apt update && apt install -y ca-certificates

COPY --from=builder /usr/src/signals/target/release/signals /usr/local/bin/signals

CMD ["signals"]
