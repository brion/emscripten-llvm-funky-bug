all: test.wast test.o.ll test.js

clean:
	rm -f test.wast test.wasm test.o.ll test.o test.js

test.wast : test.js
	~/src/emsdk/upstream/3441/bin/wasm-dis test.wasm > test.wast

test.o.ll : test.o
	~/src/emsdk/upstream/3441/bin/llvm-dis test.o

test.js : test.o
	emcc -s EXPORTED_FUNCTIONS='["_padding","_main"]' -O1 -g4 -o test.js test.o

test.o : test.c
	emcc -O1 -g4 -s WASM_OBJECT_FILES=0 -c -o test.o test.c


