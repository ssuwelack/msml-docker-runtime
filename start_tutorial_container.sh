#!/bin/bash -x

# Alexander Weigl
# 
#
#
#


function create_container()
{
	# -d start as deamon
	# -m 4G not supported
	# --rm remove old container
	# -p 220x:22 map ssh to outer world
	# --name give container a name 
	# --restart container on failure
    docker stop MSML_$1
	docker rm MSML_$1  
	docker run -d  \
		--restart=always -p 220$1:22 --name MSML_$1 \
		ssuwelack/msml_sofa /root/start_ssh.sh
}


for i in $( seq 1 25 ); do 
	create_container $(printf "%02d" $i) &
done
