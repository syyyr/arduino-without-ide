.DEFAULT_GOAL := all
out.bin: main.cpp core.a
	# Have to use the first include so that clangd doesn't get confused
	avr-gcc -I /usr/avr/include -I /usr/share/arduino/hardware/archlinux-arduino/avr/cores/arduino -I /usr/share/arduino/hardware/archlinux-arduino/avr/variants/standard -DF_CPU=16000000 -mmcu=atmega328p -Os -Wl,--gc-sections -ffunction-sections  -fdata-sections main.cpp core.a -o out.bin
	avr-strip out.bin

out.hex: out.bin
	avr-objcopy -j .text -j .data -O ihex out.bin out.hex

upload: out.hex
	avrdude-win '-CC:\Program Files (x86)\Arduino\hardware\tools\avr/etc/avrdude.conf' -v -patmega328p -carduino -PCOM3 -b115200 -D -Uflash:w:"$$(wslpath -aw "./out.hex")":i

clean:
	rm -rf out.bin out.hex core.a core_dir

core.a:
	bash arduino_core.bash

.PHONY:
all: out.hex
