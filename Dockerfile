FROM rust as builder

WORKDIR /usr/src/rojo

RUN USER=root

RUN apt-get update
RUN apt-get install musl-tools -y

COPY . /usr/src/rojo

RUN rustup target add x86_64-unknown-linux-musl

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM scratch

COPY --from=builder /usr/src/rojo/target/x86_64-unknown-linux-musl/release/rojo /rojo