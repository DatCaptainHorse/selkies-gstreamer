#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

set -e

# Create and modify permissions of XDG_RUNTIME_DIR
mkdir -pm700 /tmp/runtime-ubuntu
chown -f ubuntu:ubuntu /tmp/runtime-ubuntu
chmod -f 700 /tmp/runtime-ubuntu

export DISPLAY="${DISPLAY:-:0}"

# Configure joystick interposer
export SELKIES_INTERPOSER='/usr/$LIB/selkies_joystick_interposer.so'
export LD_PRELOAD="${SELKIES_INTERPOSER}${LD_PRELOAD:+:${LD_PRELOAD}}"
export SDL_JOYSTICK_DEVICE=/dev/input/js0
mkdir -pm777 /dev/input || sudo-root mkdir -pm777 /dev/input || echo 'Failed to create joystick interposer directory'
touch /dev/input/js0 /dev/input/js1 /dev/input/js2 /dev/input/js3 || sudo-root touch /dev/input/js0 /dev/input/js1 /dev/input/js2 /dev/input/js3 || echo 'Failed to create joystick interposer devices'

# PipeWire-Pulse server socket location
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
export PULSE_RUNTIME_PATH="${XDG_RUNTIME_DIR:-/tmp}/pulse"
export PULSE_SERVER="${PULSE_SERVER:-unix:${PULSE_RUNTIME_PATH:-${XDG_RUNTIME_DIR:-/tmp}/pulse}/native}"
export PIPEWIRE_LATENCY="32/48000"

# Start X server with required extensions
/usr/bin/Xvfb -screen :0 8192x4096x24 +extension "COMPOSITE" +extension "DAMAGE" +extension "GLX" +extension "RANDR" +extension "RENDER" +extension "MIT-SHM" +extension "XFIXES" +extension "XTEST" +iglx +render -nolisten "tcp" -noreset -shmem >/tmp/Xvfb.log 2>&1 &

# Wait for X server to start
until [ -S "/tmp/.X11-unix/X${DISPLAY/:/}" ]; do sleep 0.5; done
echo 'X Server is ready'

# Start Xfce4 Desktop session
[ "${START_XFCE4:-true}" = "true" ] && rm -rf ~/.config/xfce4 && vglrun -d "${VGL_DISPLAY:-egl}" xfce4-session &

read
