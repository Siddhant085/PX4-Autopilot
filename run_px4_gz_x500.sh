#!/usr/bin/env bash
set -e

# Repo root is where this script lives
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR="$ROOT_DIR/build/px4_sitl_default"

# 1) Start PX4 SITL (gz_x500 airframe)
cd "$BUILD_DIR"
PX4_SYS_AUTOSTART=4001 PX4_SIM_MODEL=gz_x500 \
  ./bin/px4 -s etc/init.d-posix/rcS -i $PX4_INSTANCE &
PX4_PID=$!

# 2) Start Gazebo (gz) with the x500 world
cd "$ROOT_DIR"
gz sim -r Tools/simulation/gz/worlds/x500.world &

# 3) Wait for PX4 to exit (Ctrl+C kills both)
wait $PX4_PID

