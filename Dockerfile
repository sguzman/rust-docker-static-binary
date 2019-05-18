FROM liuchong/rustup:nightly-musl AS base
RUN mkdir app
WORKDIR ./app

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml
ADD src src

RUN cargo build --package rust-docker-static-binary --bin main --verbose --jobs 4 --release --target=x86_64-unknown-linux-musl --color always

FROM scratch
COPY --from=base /root/app/target/x86_64-unknown-linux-musl/release/main /main
ENTRYPOINT ["/main"]