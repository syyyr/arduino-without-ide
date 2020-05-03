#include <Arduino.h>

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
    // This function needs to be called for timer stuff to work.
    init();

    setup();

    while (true) {
        loop();
    }

    return 0;
}

