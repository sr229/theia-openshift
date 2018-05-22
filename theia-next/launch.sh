#!/bin/sh

export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd

yarn theia start /workspace/project --hostname=0.0.0.0