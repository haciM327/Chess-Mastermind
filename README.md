# Chess Mastermind

Chess Mastermind is a project that is designed to help chess players get better at the game. Chess Mastermind does this by you inputting a chess game and it will tell you what you did right and what you did wrong. It can tell you what you should've done instead and how you can improve. It is a similar program to chess.com's game review however this program is entirely free and open-source, it can use any engine you want, and will eventually (although not yet) be able to give you in-depth help with chess strategies and tactics.

# Requirements

An amd64/x64 Linux or Windows operating system and python3 with chess pyside6 and colorama installed
# Installation
Installer files are available for Windows and Linux. Macos is not offically supported yet but you can try building from source. (No gurantees)
## Debian or Ubuntu based linux
After downloading, run:
```
cd Downloads
sudo dpkg -i chess_mastermind-0.6.0.x86_64.deb
sudo apt install -f
```

## Red Hat based linux
After downloading, run:
```
cd Downloads
sudo dnf install chess_mastermind-0.6.0.x86_64.rpm
```

## Windows
Just double click the installer

# Compilation

If you intend on compiling from source, please use the source code that comes with the release do not clone the repository as the current code has a high liklihood of not building correctly

## Prerequisites

To compile from source you will need some packages like cmake, qt6, qt6-widgets, a c/c++ compiler, python3, and git. Python also has to have a few packages installed. 

### Debian or Ubuntu based Linux

Install prerequisites
```
sudo apt-get install git cmake build-essential qt6-base-dev qml6-module-qtquick-controls qml6-module-qtqml-workerscript qml6-module-qtquick-window qml6-module-qtquick-templates python3-pip
```
If you're okay with breaking system packages then run the following with ```--break-system-packages```. If not then compile python from source and then run the command
```
python3 -m pip install pyinstaller colorama pyside6 chess
```
(Replace python3 with your python installation)
You're now all set to compile!

### Fedora or Red Hat based Linux

To install the prerequisites you will need to have root access and follow the steps below:
```
sudo dnf update
sudo dnf install cmake make gcc gcc-c++ kernel-devel qt6-qtbase-devel qt6-qtdeclarative-devel
```

On some systems global installations of python will not allow you to install pip packages, you can either overide this or install your own. Please read compiling python for more information.

To install the required packages use:
```python3 -m pip install chess pyside6 pyinstaller colorama```
(Replace python3 with your installation)

### Windows
Download and install mingw (mark gcc-gcc and gcc-g++). Add mingw/bin to path. Download and Install the latest version of qt and qt creator from the qt online installer. Add qt binary path to path. Install python and pip. Run ```python3 -m pip install chess pyside6 pyinstaller colorama```. Download and install git. Run ```git clone https://github.com/haciM327/Chess-Mastermind.git```. Open the folder in Qt Creator and compile for release. Run ```windeployqt6 Chess-Mastermind.exe``` in the build folder. Run it whenever.

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

6. All done! you have now build the project and can run it whenever.
