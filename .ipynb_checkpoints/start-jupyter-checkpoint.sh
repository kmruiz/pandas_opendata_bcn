#!/bin/bash

docker run --rm -d -p 8888:8888 --name=jupyter -e JUPYTER_ENABLE_LAB=yes -v "$PWD:/home/jovyan/work" jupyter/scipy-notebook:latest
docker logs -f jupyter &> .jupyter-logs &

sleep 1

token=$(cat .jupyter-logs | grep '127.0.0.1):8888/?token=' | tail -n1 | perl -nle 'm/\?token=([a-z0-9]+)/; print $1')
open "http://localhost:8888/?token=$token"

