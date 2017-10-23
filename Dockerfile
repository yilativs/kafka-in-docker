FROM openjdk:8-jdk 

MAINTAINER yilativs@gmail.com
ENV LAST_MODIFIDED 2017.10.22
ENV KAFKA_VERSION 0.11.0.1
ENV SCALA_VERSION 2.11
ENV KAFKA_FILE kafka_${SCALA_VERSION}-${KAFKA_VERSION}


#zookeeper and kafka will run from kafka user
RUN useradd -ms /bin/bash kafka

COPY run-kafka.sh /home/kafka/run-kafka.sh
RUN chown kafka /home/kafka/run-kafka.sh
RUN chmod u+x /home/kafka/run-kafka.sh

USER kafka
WORKDIR /home/kafka

RUN cd /home/kafka &&\
 curl -O http://apache-mirror.rbc.ru/pub/apache/kafka/${KAFKA_VERSION}/${KAFKA_FILE}.tgz  &&\
 tar -xzf ${KAFKA_FILE}.tgz --directory /home/kafka &&\
 rm ${KAFKA_FILE}.tgz  &&\
 mv /home/kafka/${KAFKA_FILE}/* /home/kafka  &&\
 rm -rf  /home/kafka/${KAFKA_FILE} 

#RUN cd /home/kafka
#RUN curl -O http://apache-mirror.rbc.ru/pub/apache/kafka/${KAFKA_VERSION}/${KAFKA_FILE}.tgz
#RUN tar -xzf ${KAFKA_FILE}.tgz --directory /home/kafka
#RUN rm {KAFKA_FILE}.tgz
#RUN mv /home/kafka/${KAFKA_FILE}/* /home/kafka
#RUN rm -rf /home/kafka/${KAFKA_FILE} 

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

#zookeeper will run on 2181, kafka will run on 9092
EXPOSE 2181 9092

ENTRYPOINT ["/bin/bash", "-c", "exec /home/kafka/run-kafka.sh"]

