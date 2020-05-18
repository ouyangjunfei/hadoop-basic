#!/bin/bash

echo 'Start running hadoop master container...'
docker run -di \
           --name=master \
           --hostname=master \
           --network=hadoop \
           spark:1.0

echo 'Start running hadoop worker containers...'
docker run -di \
           --name=worker1 \
           --hostname=worker1 \
           --network=hadoop \
           spark:1.0

echo -e 'Done\n'
