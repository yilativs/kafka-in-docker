#!/bin/sh
/home/kafka/bin/zookeeper-server-start.sh -daemon /home/kafka/config/zookeeper.properties 
/home/kafka/bin/kafka-server-start.sh /home/kafka/config/server.properties
