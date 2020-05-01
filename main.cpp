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

int main(void)
{
    init();

    initVariant();

#if defined(USBCON)
    USBDevice.attach();
#endif

    Serial.begin(9600);

    lib::string toPrint(300);
    long counter = 0;
    while (true) {
        sprintf(toPrint.get(), "%ld * %ld = %ld", counter, counter, square(counter));
        Serial.println(toPrint.get());
        counter++;

        if (serialEventRun) serialEventRun();
    }

    return 0;
}

