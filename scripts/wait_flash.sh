#!/bin/bash
THIS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
"$THIS_DIR/wait_copy.sh" /Volumes/NICENANO "$1" 2
