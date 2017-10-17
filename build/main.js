function loadWasm() {
    const importObj = {
        env: {
            print: console.log,
        }
    };

    fetch('current/main.wasm')
        .then(response => response.arrayBuffer())
        .then(buffer => WebAssembly.instantiate(buffer, importObj))
        .then(({module, instance}) => {
            console.log(instance.exports.print_twenty_seven_more);
            console.log(instance.exports.print_twenty_seven_more(4));
        })
    ;
}

loadWasm();