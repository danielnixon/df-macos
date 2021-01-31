#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Download df itself
curl -LO https://www.bay12games.com/dwarves/df_47_05_osx.tar.bz2

# Download Mayday graphics
curl -LO https://github.com/DFgraphics/Mayday/archive/47.04.tar.gz

# Extract both
tar -xf df_47_05_osx.tar.bz2
tar -xf 47.04.tar.gz

# Copy the Mayday graphics set into place
cp -r Mayday-47.04/data/art/* df_osx/data/art/
cp -r Mayday-47.04/data/init/* df_osx/data/init/
cp -r Mayday-47.04/raw/objects/* df_osx/raw/objects/
cp -r Mayday-47.04/raw/graphics/* df_osx/raw/graphics/

# Fix run permission on macos
xattr -d com.apple.quarantine df_osx/dwarfort.exe || true
xattr -d com.apple.quarantine df_osx/libs/libfmodex.dylib || true
xattr -d com.apple.quarantine df_osx/libs/libgcc_s.1.dylib || true
xattr -d com.apple.quarantine df_osx/libs/SDL.framework || true
xattr -d com.apple.quarantine df_osx/libs/SDL_image.framework || true
xattr -d com.apple.quarantine df_osx/libs/SDL_ttf.framework || true

# Fix rendering on macos
sed -i "" "s/\[PRINT_MODE:2D\]/\[PRINT_MODE:STANDARD\]/" df_osx/data/init/init.txt
