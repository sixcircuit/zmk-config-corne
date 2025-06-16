#!/bin/bash
THIS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
"$THIS_DIR/wait_flash.sh" ./build/corne_left.uf2
