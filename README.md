# Chess Mastermind

Chess Mastermind is a project that is designed to help chess players get better at the game. Chess Mastermind does this by you inputting a chess game and it will tell you what you did right and what you did wrong. It can tell you what you should've done instead and how you can improve. It is a similar program to chess.com's game review however this program is entirely free and open-source, it can use any engine you want, and will eventually (although not yet) be able to give you in-depth help with chess strategies and tactics.

# Requirements

An amd64/x64 Linux or Windows operating system and python3.10 (other versions not tested)
# Installation
Installer files are available for Windows and Linux. Double-click to install. On Linux you will need to add /usr/local/bin/chess-mastermind to the path (fix coming). For Macos or other operating systems, you will need to build from source. Keep in mind these operating systems are not officially supported and may not work as intended.

# Compilation

If you intend on compiling from source, please use the source code that comes with the release do not clone the repository as the current code has a high liklihood of not building correctly

## Prerequisites

To compile from source you will need some basic tools like cmake, qt6, qt6-widgets, a c/c++-compiler, python3.10, and git. Python also has to have chess and pygame installed. They can be installed like ```python -m pip install chess pygame``` 

### Debian or Ubuntu based Linux

To install the prerequisites you will need to have root access and follow the steps below:

```
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install build-essential cmake qt6-base-dev libgl1-mesa-dev git
```

Now you need to install python which may have right version pre-installed depending on the version of Linux you are using. You can check with ```python3 --version```.
If it returns a python3.10 version you can run ```sudo apt-get install python3-dev``` and have everything all set to go and you can skip the next steps!

If the right version is not installed you will need to build python from source. Use the following commands:

```
wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz
tar -xf python-3.10.13.tgz
cd python-3.10.13
mkdir build && cd build
../configure --enable-optimizations
make
sudo make install
```
Feel free to change and customize the above steps to fit your python needs!
Now all prerequisites are installed and you can start compiling!

### Other Linuxs

I don't know, use yum or whatever.

### Windows

Install you favorite c/c++ compiler whether that be mingw or msvc. Install cmake and python from [cmake.org](cmake.org) and [python.org](python.org) respectively. Install github desktop from github or whatever git you use. Open up powershell and follow the compilation steps below

## Compiling

1. Move into the repository with:

   ```cd Chess-Mastermind```
   
2. Make a build directory and move into it

   ```mkdir build && cd build```

3. Run cmake to make create the build space

   ```cmake ..```

4. Build the files

   ```cmake --build . --config Release```

5. All done! you have now build the project and can run it whenever. You can install it to any directory you want.
