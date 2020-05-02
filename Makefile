.DEFAULT_GOAL := all
SERIAL_PORT=3
MMCU=atmega328p
CPU_CLOCK=16000000
out.bin: main.cpp core.a
	# Have to use the first include so that clangd doesn't get confused
	avr-g++ -std=c++17 -I /usr/avr/include -I /usr/share/arduino/hardware/archlinux-arduino/avr/cores/arduino -I /usr/share/arduino/hardware/archlinux-arduino/avr/variants/standard -DF_CPU=$(CPU_CLOCK) -mmcu=$(MMCU) -Os -Wl,--gc-sections -flto -ffunction-sections -fdata-sections main.cpp core.a -o out.bin
	avr-strip out.bin

out.hex: out.bin
	avr-objcopy -j .text -j .data -O ihex out.bin out.hex

.PHONY:
upload: out.hex
	avrdude -v -p atmega328p -c arduino -P /dev/ttyS$(SERIAL_PORT) -b 115200 -D -U flash\:w:out.hex\:i

clean:
	rm -rf out.bin out.hex core.a core_dir

core.a:
	bash arduino_core.bash

.PHONY:
all: out.hex
