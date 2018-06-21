# springboot-task-deploy
#
# This image provide a base for running Spring Boot based applications. It
# provides a base Java 8 installation.

FROM centos:centos7

EXPOSE 8080

ENV JAVA_VERSON 1.8.0

LABEL io.k8s.description="Platform for running Spring Boot applications" \
  io.k8s.display-name="Spring Boot" \
  io.openshift.expose-services="8080:http" \
  io.openshift.tags="builder,java8,springboot"

USER root

RUN yum update -y && \
  yum install -y curl && \
  yum install -y java-$JAVA_VERSON-openjdk java-$JAVA_VERSON-openjdk-devel && \
  yum clean all

ENV JAVA_HOME /usr/lib/jvm/java  

RUN mkdir -p /opt/app-root
RUN chown -R 1001:0 /opt/app-root
USER 1001
COPY spring-boot.jar /opt/app-root/spring-boot.jar

CMD java -jar /opt/app-root/spring-boot.jar