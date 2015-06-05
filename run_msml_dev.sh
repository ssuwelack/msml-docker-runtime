#!/bin/sh
if test $# -lt 1; then
	# Get the latest msml_docker build
	# and start with an interactive terminal enabled
	args="-i -t $(docker images | grep ^ssuwelack/msml_dev | head -n 1 | awk '{ print $1":"$2 }')"
else
        # Use this script with derived images, and pass your 'docker run' args
	args="$@"
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth-$USER
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run \
	-v $XSOCK:$XSOCK:rw \
	-v $XAUTH:$XAUTH:rw \
	--device=/dev/dri/card0:/dev/dri/card0 \
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=$XAUTH \
	$args 
