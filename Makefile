ASM=fasm
SRC_DIR=src
BUILD_DIR=build

.PHONY: all clean

SRCS=$(wildcard $(SRC_DIR)/*.asm)
OBJS=$(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.bin,$(SRCS))

all: $(OBJS)

$(BUILD_DIR)/%.bin: src/%.asm
	fasm $< $@

clean:
	rm -rf $(BUILD_DIR)

$(shell mkdir -p $(BUILD_DIR))
