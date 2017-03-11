# Pull base os image.
FROM ubuntu:14.04

#Pull maven base image with java 1.8+ 
#FROM maven:3.3.9-jdk-8

MAINTAINER Anil Kumar <anilkumardahiya7@gmail.com>

LABEL io.irlabs.web-app="java-app"
LABEL version="1.0"
LABEL description="Crossover Java Web App"

#Install build essentials
RUN apt-get -y update && apt-get -y install software-properties-common 

#Install Java 8
RUN  set -x  && \
#    apt-add-repository -y ppa:webupd8team/java && \
   add-apt-repository -y ppa:openjdk-r/ppa && \
   apt-get -y update && \
#  apt-get -y install oracle-java8-installer 
   apt-get -y install openjdk-8-jdk

#Install mvn 
#ADD http://mirror.fibergrid.in/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz /opt/
COPY apache-maven-3.3.9-bin.tar.gz /opt/
RUN cd /opt && tar xzf /opt/apache-maven-3.3.9-bin.tar.gz  
ENV PATH=/opt/apache-maven-3.3.9/bin:$PATH

EXPOSE 8080

RUN mkdir -p /opt/crossover
COPY crossover/Code /opt/crossover/ 

WORKDIR /opt/crossover/


ENTRYPOINT ["mvn"]
CMD ["spring-boot:run"]
