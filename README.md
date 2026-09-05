# Chess Mastermind

Chess Mastermind is a project that is designed to help chess players get better at the game. Chess Mastermind does this by you inputting a chess game and it will tell you what you did right and what you did wrong. It can tell you what you should've done instead and how you can improve. It is a similar program to chess.com's game review however this program is entirely free and open-source, it can use any engine you want, and will eventually (although not yet) be able to give you in-depth help with chess strategies and tactics.

# Compilation

## Prerequisites

To compile from source you will need some packages like cmake, qt6, qt6-widgets, a c/c++ compiler.

### Debian or Ubuntu based Linux

Install prerequisites
```
sudo apt-get install git cmake build-essential qt6-base-dev qt6-declarative-dev libcurl4-openssl-dev libarchive-dev
```

### Fedora based Linux

To install the prerequisites you will need to have root access and follow the steps below:
```
sudo dnf update
sudo dnf install git cmake make gcc gcc-c++ kernel-devel qt6-qtbase-devel qt6-qtdeclarative-devel libcurl-devel libarchive-devel
```

## Compiling

1. Clone the repository with:

   ```git clone https://github.com/haciM327/Chess-Mastermind.git```

2. Move into the repository with:

   ```cd Chess-Mastermind```

3. Make a build directory and move into it

   ```mkdir build && cd build```

4. Run cmake to make create the build space

   ```cmake ..```

   On some distributions you may get a series of warnings saying that certain qml plugins cannot be found and will not be linked. It is safe to ignore these.

6. Build the files

   ```make -j${nproc}```

   The ```-j${nproc}``` tells the computer to use the maximum number of threads available. You can omit this or instead of ```${nproc}``` you can specify a number of threads to use.

8. All done! you have now build the project and can run it whenever.
