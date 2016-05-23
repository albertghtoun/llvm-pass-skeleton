INPUT=${1}

clang -emit-llvm examples/${INPUT}.c -c -o examples/${INPUT}.bc
rm -fr build
mkdir -p build
cd build
cmake .. && make clean && make
cd ..
opt -load build/skeleton/libCS201Profiling.so -pathProfiling examples/${INPUT}.bc -S -o examples/${INPUT}.ll && \
    llvm-as examples/${INPUT}.ll -o examples/${INPUT}.bb.bc && \
    lli examples/${INPUT}.bb.bc

