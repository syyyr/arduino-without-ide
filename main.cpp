#include <Arduino.h>
#include "arduino_decls.hpp"

int main(void)
{
    init();

    initVariant();

#if defined(USBCON)
    USBDevice.attach();
#endif

    Serial.begin(9600);

    for (;;) {
        Serial.write("AHOJDA");   // read it and send it out Serial1 (pins 0 & 1)
        delay(1000);

        if (serialEventRun) serialEventRun();
    }

    return 0;
}

