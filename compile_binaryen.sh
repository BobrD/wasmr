#!/bin/bash


if [ -z ${1+x} ]; then
    echo "missing argument: rust source file";
    exit 1
fi

rust_source="${1%.*}"

file_name=$(basename $rust_source)

build_dir="build/current";

mkdir -p "${build_dir}"

rm -rf build/current/*

# compilation pipe .rs -> .bs -> .s -> .wast -> .wasm

# 1) compile rust to llvm byte code (.rs -> .bs)
rustc --crate-type=lib --emit=llvm-bc "${rust_source}.rs"
# 2) mv to build dir
mv "./${file_name}.bc" "./${build_dir}/${file_name}.bc"
# 3) convert llvm-bc to wasm assembly in a linear assembly format (.bs -> .s)
./toolchain/llvm/build/bin/llc -march=wasm32 "./${build_dir}/${file_name}.bc"
# 4) convert the .s assembly into an s-expression assembly format (.s -> .wast)
./toolchain/binaryen/bin/s2wasm -o "./${build_dir}/${file_name}.wast" "${build_dir}/${file_name}.s"
# 5) assembly the wast file into the binary format (.wast -> .wasm)
./toolchain/binaryen/bin/wasm-as "./${build_dir}/${file_name}.wast"