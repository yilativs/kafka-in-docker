FROM openjdk:8-jdk 

#zookeeper and kafka will run from kafka user
RUN useradd -ms /bin/bash kafka

ADD run-kafka.sh /home/kafka/run-kafka.sh
RUN chown kafka /home/kafka/run-kafka.sh
RUN chmod u+x /home/kafka/run-kafka.sh

USER kafka
WORKDIR /home/kafka

RUN cd /home/kafka &&\
curl -O http://apache-mirror.rbc.ru/pub/apache/kafka/0.11.0.1/kafka_2.11-0.11.0.1.tgz  &&\
tar -xzf kafka_2.11-0.11.0.1.tgz --directory /home/kafka  &&\
rm kafka_2.11-0.11.0.1.tgz  &&\
mv /home/kafka/kafka_2.11-0.11.0.1/* /home/kafka  &&\
rm -rf  /home/kafka/kafka_2.11-0.11.0.1 

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

EXPOSE 2181 9092

ENTRYPOINT ["/bin/bash", "-c", "exec /home/kafka/run-kafka.sh"]

