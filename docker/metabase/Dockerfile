FROM registry.access.redhat.com/ubi7/s2i-core:latest

EXPOSE 3000

LABEL io.openshift.expose-services="3000:http"

RUN yum install -y git java-1.8.0-openjdk-devel && yum clean all

COPY metabase.jar .

ENTRYPOINT ["java", "-jar", "metabase.jar"]
