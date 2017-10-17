FROM trzeci/emscripten-slim:sdk-tag-1.37.22-64bit

RUN apt-get update && \
    apt-get install curl -y && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN apt-get install build-essential -y

RUN ~/.cargo/bin/rustup override set nightly

RUN ~/.cargo/bin/rustup target add asmjs-unknown-emscripten

RUN ~/.cargo/bin/cargo install cargo-web