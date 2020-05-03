.DEFAULT_GOAL := all
SERIAL_PORT=3
ARDUINO_HOME=/usr/share/arduino/hardware/archlinux-arduino
CORES_DIR=$(ARDUINO_HOME)/avr/cores/arduino
INCLUDE_STANDARD=$(ARDUINO_HOME)/avr/variants/standard
MMCU=atmega328p
CPU_CLOCK=16000000
F_CPU=16000000L
ARDUINO=10812
PLATFORM_GCC_FLAGS=-mmcu=$(MMCU) -DF_CPU=$(F_CPU) -DARDUINO=$(ARDUINO) -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR
CPP_STANDARD=c++17
# Have to use /usr/avr/include so that clangd doesn't get confused
INCLUDES=-I /usr/avr/include -I $(CORES_DIR) -I $(INCLUDE_STANDARD)
F_OPTIONS=-fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto
COMPILER_FLAGS=-std=$(CPP_STANDARD) $(INCLUDES) $(PLATFORM_GCC_FLAGS) -Os -Wl,--gc-sections $(F_OPTIONS)
out.bin: main.cpp core.a
	avr-g++ -g -Os -Wall -pedantic -fuse-linker-plugin $(COMPILER_FLAGS) main.cpp core.a -o out.bin -lm
	avr-strip out.bin

out.hex: out.bin
	avr-objcopy -R .eeprom -O ihex out.bin out.hex

.PHONY:
upload: out.hex
	avrdude -v -p atmega328p -c arduino -P /dev/ttyS$(SERIAL_PORT) -b 115200 -D -U flash\:w:out.hex\:i

clean:
	rm -rf out.bin out.hex core.a core_dir

core.a: arduino_core.bash
	bash arduino_core.bash

.PHONY:
all: out.hex
