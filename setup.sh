#!/bin/bash

# When starting up docker, docker takes control of the persisted
# data in local_data/. When trying to restart docker, the new 
# owner of local_data/ (777, 90, docker, etc.) will make the 
# docker-compose command fail (permission error). Run this command
# to fix the permissions and allow the container to be started.

sudo chown -R $USER:$USER local_data
chmod 755 -R local_data
