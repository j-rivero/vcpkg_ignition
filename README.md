# ignition-math2 vcpkg

This repo contains an early test and implemention of ignition-math2 port for
the vcpkg Windows package manager. Tested using Windows 10 using VisualStudio
14 2015 Express g

# How to test

## Install ignition-math2 package

Place ports/ignition-math2 directory into C:\Users\YOUR_PATH_TO_VCPKG\ports

`.\vcpkg.exe install ignition-math2:x64-windows`

## Run the test using the installed ignition-math2 library

```
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86_amd64
cd ign_test
mdkir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=C:\Users\YOUR_PATH_TO_VCPKG\scripts\buildsystems\vcpkg.cmake -G "Visual Studio 14 2015 Win64
msbuild ALL.msbuild
```
