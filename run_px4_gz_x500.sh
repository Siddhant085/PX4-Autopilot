#!/usr/bin/env bash
set -e

# Repo root is where this script lives
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR="$ROOT_DIR/build/px4_sitl_default"

#export GZ_SIM_RESOURCE_PATH=$ROOT_DIR/Tools/simulation/gz/worlds:$ROOT_DIR/Tools/simulation/gz/models:$GZ_SIM_RESOURCE_PATH

# Path to the Gazebo world you actually want
#WORLD="$ROOT_DIR/Tools/simulation/gz/worlds/default"


# 1) Start PX4 SITL (gz_x500 airframe)
cd "$BUILD_DIR"
source rootfs/gz_env.sh
export PX4_SYS_AUTOSTAR=4014
export PX4_INSTANCE=1
export PX4_SIM_MODEL=gz_x500_mono_cam_down
./bin/px4  -i $PX4_INSTANCE 
PX4_PID=$!

# 2) Start Gazebo (gz) with the x500 world
#cd "$ROOT_DIR"
#gz sim -r Tools/simulation/gz/worlds/x500.world &

# 3) Wait for PX4 to exit (Ctrl+C kills both)
#wait $PX4_PID

