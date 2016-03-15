#!/bin/bash

# Clean up stopped Docker containers

docker ps -a | grep -v CONTAINER | grep Exited | awk '{print $1}' | xargs docker rm
