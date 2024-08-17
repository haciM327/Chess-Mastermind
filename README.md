# Chess Mastermind

Chess Mastermind is a project that is designed to help chess players get better at the game. Chess Mastermind does this by you inputting a chess game and it will tell you what you did right and what you did wrong. It can tell you what you should've done instead and how you can improve. It is a similar program to chess.com's game review however this program is entirely free and open-source, it can use any engine you want, and will eventually (although not yet) be able to give you in-depth help with chess strategies and tactics.

# Requirements

An amd64/x64 Linux or Windows operating system and python3 with chess pyside6 and colorama installed
# Installation
Installer files are available for Windows and Linux. Double-click to install. On Linux you will need to add /usr/local/bin/chess-mastermind to the path (fix coming). For Macos or other operating systems, you will need to build from source. Keep in mind these operating systems are not officially supported and may not work as intended.

# Compilation

If you intend on compiling from source, please use the source code that comes with the release do not clone the repository as the current code has a high liklihood of not building correctly

## Prerequisites

To compile from source you will need some packages like cmake, qt6, qt6-widgets, a c/c++ compiler, python3, and git. Python also has to have a few packages installed. 

### Debian or Ubuntu based Linux

To install the prerequisites you will need to have root access and follow the steps below:

```
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install build-essential cmake qt6-base-dev qt6-declarative-dev libgl1-mesa-dev git
```

On some systems global installations of python will not allow you to install pip packages, you can either overide this or install your own. Please read compiling python for more information.

To install the required packages use:
```python3 -m pip install chess pyside6 pyinstaller colorama```
(Replace python3 with your installation)

### Fedora or Red Hat based Linux

To install the prerequisites you will need to have root access and follow the steps below:
```
sudo dnf update
sudo dnf install cmake make gcc gcc-c++ kernel-devel qt6-qtbase-devel qt-declarative-devel
```

On some systems global installations of python will not allow you to install pip packages, you can either overide this or install your own. Please read compiling python for more information.

To install the required packages use:
```python3 -m pip install chess pyside6 pyinstaller colorama```
(Replace python3 with your installation)

### Windows

Install you favorite c/c++ compiler. Install cmake and python from [cmake.org](cmake.org) and [python.org](python.org) respectively. Install git. Open up powershell and follow the compilation steps below

## Compiling

1. Clone the repository with:

   ```git clone https://github.com/haciM327/Chess-Mastermind.git```
   
2. Move into the repository with:

   ```cd Chess-Mastermind```
   
3. Make a build directory and move into it

   ```mkdir build && cd build```

4. Run cmake to make create the build space

   ```cmake ..```

5. Build the files

   ```make -j${nproc}```

6. All done! you have now build the project and can run it whenever. You can install it to any directory you want.