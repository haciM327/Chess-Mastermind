# Chess Mastermind
Chess Mastermind is a project that is designed to help chess players get better at the game. Chess Mastermind does this by you inputting a chess game and it will tell you what you did right and what you did wrong. It can tell you what you should've done instead and how you can improve. It is a similar program to chess.com's game review however this program is entirely free and open-source, it can use any engine you want, and will eventually (although not yet) be able to give you in depth help with chess stratgies and tactics.

# Installation
No installer file is provided yet, instead a portable binary is provided which can be manually extracted and installed anywhere

# Compilation
Compiling from source is not recomended however, if you desire to do so the easiest way is to open the project in QT Creator and compile it from there. Compiling from the command line can be done though.
1. First create and enter a build directory, i.e.\
  ```mkdir build``` and ```cd build```
2. Run cmake from the build directory\
   ```cmake ..```
3. Build the project using release configuration\
  ```cmake --build . -configure Release```
4. Run the app!
