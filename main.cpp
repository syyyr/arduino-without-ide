#include <Arduino.h>
#include "arduino_decls.hpp"

namespace lib {
class string {
public:
    string(size_t len)
        : m_str(new char[len])
    {
    }

    char* get()
    {
        return m_str;
    }

    ~string()
    {
        delete[] m_str;
    }

private:
    char* m_str;
};
}

long square(long x)
{
    return x * x;
}

lib::string toPrint(300);
long counter = 0;

void setup()
{
    Serial.begin(9600);
}

void loop()
{
    sprintf(toPrint.get(), "%ld * %ld = %ld", counter, counter, square(counter));
    Serial.println(toPrint.get());
    counter++;
}

int main(void)
{
    init();

    initVariant();

#if defined(USBCON) // This might only be useful for the IDE, it matter if it's here tho, since it's inside this ifdef
    USBDevice.attach();
#endif

    setup();

    while (true) {
        loop();
        if (serialEventRun) serialEventRun();
    }

    return 0;
}

