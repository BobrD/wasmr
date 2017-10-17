#!/bin/bash

~/.cargo/bin/cargo build --target=asmjs-unknown-emscripten
mkdir -p site
cp ./target/asmjs-unknown-emscripten/debug/wasmr.js site/asm.js