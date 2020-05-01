# Arduino developing with Arduino IDE

I don't like IDEs (and especially the very trashy Arduino IDE editor), so I
tried to recreate what Arduino IDE does for you (i. e. compile stuff and upload
stuff). The biggest problem was compiling the Arduino core library. I copied
most of the commands directly from the IDE and that seems to work.

## Advantages
- You can use your favorite editor to write code.
- You can use the command line to develop instead of being dependent on a GUI.

## Disadvantages
- This might not work for everyone. It does for me, but the Makefile isn't too
  generic, so it could happen, that it only works for me.
- The resulting binary file is a little bigger than what the IDE produces. The
  example produces a 3842 byte binary, while my solution gives me a 4030 bytes
  binary. That's about 5% more. Admittedly that's not too much, but it could
  matter on a system where every byte counts.
- You lose some of the functionality of the Arduino "language". For example,
  you can't just define a loop and a setup function, you have to structure your
  program as a normal C program (so you have to supply your own `main`
  function). I abstracted most of the Arduino `main` function into the
  `arduino_decls.hpp` file, but not everything can be put there. The exact
  functionality could probably be implemented here too, but I don't mind
  compiling my own `main` function this functionality (although it maybe a good
  idea to look into how `main` is compiled in A-IDE to see where I get those
  additional bytes).
