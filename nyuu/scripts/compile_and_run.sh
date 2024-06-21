#!/bin/zsh

gcc -o program "$1" && echo "Compilation successful." || echo "Compilation failed."

if [[ -f ./program ]]; then
  ./program
else
  echo "Executable not found. Check compilation errors."
fi
