.DEFAULT_GOAL := all
main.bin: main.cpp core.a
	avr-gcc -I /usr/share/arduino/hardware/archlinux-arduino/avr/cores/arduino -I /usr/share/arduino/hardware/archlinux-arduino/avr/variants/standard -DF_CPU=16000000 -mmcu=atmega328p -Os -Wl,--gc-sections -ffunction-sections  -fdata-sections main.cpp core.a -o main.bin
	avr-strip main.bin

main.hex: main.bin
	avr-objcopy -j .text -j .data -O ihex main.bin main.hex

upload: main.hex
	avrdude-win '-CC:\Program Files (x86)\Arduino\hardware\tools\avr/etc/avrdude.conf' -v -patmega328p -carduino -PCOM3 -b115200 -D -Uflash:w:"$$(wslpath -aw "./main.hex")":i

clean:
	rm -rf main.bin main.hex core.a core_dir

core.a:
	bash arduino_core.bash

.PHONY:
all: main.hex
