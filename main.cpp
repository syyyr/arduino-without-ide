#include <Arduino.h>

// Declared weak in Arduino.h to allow user redefinitions.
int atexit(void (* /*func*/ )()) { return 0; }

// Weak empty variant initialization function.
// May be redefined by variant files.
void initVariant() __attribute__((weak));
void initVariant() { }

void setupUSB() __attribute__((weak));
void setupUSB() { }

int main(void)
{
    init();

    initVariant();

#if defined(USBCON)
    USBDevice.attach();
#endif

    Serial.begin(9600);

    for (;;) {
        Serial.write("AHOJ");   // read it and send it out Serial1 (pins 0 & 1)
        delay(1000);

        if (serialEventRun) serialEventRun();
    }

    return 0;
}

