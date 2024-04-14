.PHONY: debug debug-build release-build build run debug dump-dag dump-dag2 dump-isel

SRC=clip.ll
FLAG=-mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+f,+d -o -

COMMAND=./build/bin/llc $(FLAG) $(SRC)

debug-build: 
	cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DLLVM_ENABLE_PROJECTS="clang" -DLLVM_TARGETS_TO_BUILD=RISCV

run: 
	$(COMMAND)

dump-isel: 
	$(COMMAND) --print-after-isel

build: 
	ninja -C build

build-main:
	ninja -C build-main

release-build:
	cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang"

debug: 
	lldb -- $(COMMAND)

dump-dag:
	$(COMMAND) -view-dag-combine1-dags

dump-dag2: 
	$(COMMAND) -view-dag-combine2-dags





