ASM=nasm
BUILD_DIR=build

test: $(BUILD_DIR)/test.bin
	qemu-system-x86_64 -fda $(BUILD_DIR)/test.bin

$(BUILD_DIR)/test.bin: test.asm
	$(ASM) test.asm -f bin -o $(BUILD_DIR)/test.bin
