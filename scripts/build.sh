#/bin/bash

set -e

RED='\033[0;31m'
C='\033[0m' # No Color

# NOTE: this will only works when run under the devcontainer
# go to workspace dir, if missing that means its not container
cd /workspaces/zmk || exit 1

if [ ! -d .west ]; then
   echo -e "${RED}---> Initializing west workspace....${NC}"
    west init -l app
    west update
fi

export CMAKE_PREFIX_PATH=/workspaces/zmk/zephyr:\$CMAKE_PREFIX_PATH

echo -e "${RED}---> Cleaning old build files...${NC}"
rm -rf /workspaces/zmk/build/*

echo -e "${RED}---> Building corne_left...${NC}"
west build -d build/left -p -b nice_nano_v2 \
   -s app \
   -- -DSHIELD='corne_left nice_view_adapter nice_view' \
      -DZMK_EXTRA_MODULES="/workspaces/modules/zmk-tri-state" \
      -DZMK_CONFIG=/workspaces/config/config
cp build/left/zephyr/zmk.uf2 /workspaces/out/corne_left.uf2

# echo -e "${RED}---> Building corne_right...${NC}"
# west build -d build/right -p -b nice_nano_v2 \
#    -s app \
#    -- -DSHIELD='corne_right nice_view_adapter nice_view' \
#       -DZMK_EXTRA_MODULES="/workspaces/modules/zmk-tri-state" \
#       -DZMK_CONFIG=/workspaces/config/config
# cp build/right/zephyr/zmk.uf2 /workspaces/out/corne_right.uf2

# echo -e "${RED}---> Building corne_right...${NC}"
#  west build -d build/right -p -b nice_nano_v2 \
#    -s app \
#    -- -DSHIELD='corne_right nice_view_adapter nice_view' \
#       -DZMK_EXTRA_MODULES="/workspaces/zmk-tri-state" \
#       -DZMK_CONFIG=/workspaces/config/config
#  cp build/right/zephyr/zmk.uf2 /workspaces/out/corne_right.uf2

# west build -p -d build/lynx_left -b nice_nano_v2 --      
#    -DSHIELD="lynx_left nice_view_adapter nice_view"
#    -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word"
#    -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
# west build -p -d build/lynx_left -b nice_nano_v2 -- -DSHIELD="lynx_left nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

# echo -e "${RED}---> Building corne_right...${NC}"
 # west build -d build/right -p -b nice_nano_v2 \
 #   -s app \
 #   -- -DSHIELD='corne_right nice_view_adapter nice_view' \
 #      -DZMK_CONFIG=/workspaces/config/config
 # cp build/right/zephyr/zmk.uf2 /workspaces/out/corne_right.uf2

 # echo '🔨 Building settings_reset...'
 # west build -d build/reset -p -b nice_nano_v2 \
 #   -s app \
 #   -- -DSHIELD='settings_reset' \
 #      -DZMK_CONFIG=/workspaces/config/config
 # cp build/reset/zephyr/zmk.uf2 /workspaces/out/settings_reset.uf2

 echo '✅ Done! UF2 files are in build-out/'

