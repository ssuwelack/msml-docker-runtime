#!/bin/sh
if test $# -lt 1; then
	# Get the latest msml_docker build
	# and start with an interactive terminal enabled
	args="-d $(docker images | grep ^ssuwelack/msml_dev | head -n 1 | awk '{ print $1":"$2 }') /root/start_ssh.sh"
else
        # Use this script with derived images, and pass your 'docker run' args
	args="$@"
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run \
  -p 127.0.0.1:22000:22 \
  --name msml_sofa \
	$args 


