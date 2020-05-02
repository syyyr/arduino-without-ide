# Arduino developing without Arduino IDE

I don't like IDEs (and especially the very trashy Arduino IDE (A-IDE) editor), so I
tried to recreate what A-IDE does for you (i. e. compile stuff and upload
stuff). The biggest problem was compiling the Arduino core library. I copied
most of the commands directly from the IDE and that seems to work.

## Advantages
- You can use your favorite editor to write code[1].
- You can use whatever compiler you want. I use GCC 9 which gives me a lot of
  C++17 features. The A-IDE on my PC uses GCC 7.
- You can use the command line to develop instead of being dependent on a GUI.

## Disadvantages
- This might not work for everyone and most likely won't work
  out-of-the-box[2]. At least some of the values inside the Makefile will have
  to be changed to match your device.
- The resulting binary file is a little bigger than what the IDE produces[3].
  This could be solved by looking more into how A-IDE compiles things. Also,
  A-IDE does some clever pre-proccessing stuff, so that might be the cause of
  the increased code size.
- You lose some of the functionality of the Arduino "language". For example,
  you can't just define a loop and a setup function, you have to structure your
  program as a normal C program (so you have to supply your own `main`
  function). The exact functionality could probably be implemented here too,
  but I don't mind compiling my own `main` function this functionality
  (although it maybe a good idea to look into how `main` is compiled in A-IDE
  to see where I get those additional bytes). The example does mimic the A-IDE
  approach with the setup and loop functions.

## Dependencies
I use this on Arch Linux (inside WSL! so you can use that if you want) with the
`arduino-avr-core` package installed.

## Notes
[1] Admittedly, you can write your code outside of A-IDE and then copy/reopen
the file inside the IDE.

[2] If you have Arduino Uno, then it could work OOTB, since I use a clone of
Arduino Uno.

[3] The example produces a 3490 byte binary, while my solution gives me a 3712
bytes binary. That's about 6% more. Admittedly that's not too much, but it
could matter on a system where every byte counts. Also, with more complex
programs, the difference could increase.
