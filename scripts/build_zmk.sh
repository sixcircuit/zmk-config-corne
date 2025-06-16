#!/bin/bash
set -euo pipefail

THIS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
PROJ_DIR="$THIS_DIR/../.."

ZMK_DIR="$PROJ_DIR/zmk"
MODULES_DIR="$PROJ_DIR/modules"
CONFIG_DIR="$PROJ_DIR/zmk-config-corne"
TEMP_DIR="$PROJ_DIR/build"

IMAGE=zmkfirmware/zmk-build-arm:3.5-branch

rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

echo "🚀 Launching ZMK build container..."

   echo docker run -it --rm \
     --security-opt label=disable \
     -v "$ZMK_DIR:/workspaces/zmk" \
     -v "$CONFIG_DIR:/workspaces/config" \
     -v "$MODULES_DIR:/workspaces/modules" \
     -v "$TEMP_DIR:/workspaces/out" \
     -w /workspaces/zmk \
   "$IMAGE" /bin/bash

if [[ "${1:-}" == "-i" ]]; then
   docker run -it --rm \
     --security-opt label=disable \
     -v "$ZMK_DIR:/workspaces/zmk" \
     -v "$CONFIG_DIR:/workspaces/config" \
     -v "$MODULES_DIR:/workspaces/modules" \
     -v "$TEMP_DIR:/workspaces/out" \
     -w /workspaces/zmk \
   "$IMAGE" /bin/bash
else
   docker run -it --rm \
     --security-opt label=disable \
     -v "$ZMK_DIR:/workspaces/zmk" \
     -v "$CONFIG_DIR:/workspaces/config" \
     -v "$MODULES_DIR:/workspaces/modules" \
     -v "$TEMP_DIR:/workspaces/out" \
     -w /workspaces/zmk \
     "$IMAGE" /bin/bash -c '/workspaces/config/scripts/build.sh'
fi
