#!/bin/bash

echo 'Start running hadoop master container...'
docker run -di \
           -p 50070:50070 \
           -p 8088:8088 \
           -p 8081:8080 \
           -p 7077:7077 \
           -p 4041:4040 \
           -p 50075:50075 \
           --name=master \
           --hostname=master \
           --network=hadoop \
           spark:1.0 \
           /bin/bash

echo 'Start running hadoop worker containers...'
docker run -di \
           --name=worker1 \
           --hostname=worker1 \
           -p 8082:8081 \
           --network=hadoop \
           spark:1.0 \
           /bin/bash


echo -e 'Done\n'
