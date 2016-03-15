#!/bin/bash

# Stop all running Docker containers

docker ps | grep -v CONTAINER | awk '{print $1}' | xargs docker stop
