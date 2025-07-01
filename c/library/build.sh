#!/bin/bash

set -e

mkdir -p build

cmake -S . -B build/cmake -DCMAKE_INSTALL_PREFIX=build/out
cmake --build build/cmake --config Release
cmake --install build/cmake --config Release
