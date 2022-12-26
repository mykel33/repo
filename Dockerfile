FROM crm-nexus.itg.echonet/openjdk:11.0.12.0.7-0.el8_4
ENV SPRING_CONFIG_ADDITIONAL_LOCATION /applis/config/

# ARTIFACT, GITBRANCH et GITCOMMIT seront surchargés au moment du build
# Laisser ces valeurs par défaut
ARG ARTIFACT=api-v360-dmzr-*.jar
ARG GITBRANCH=master
ARG GITCOMMIT=0000000

ARG PUID=1024
ARG PGID=1024

#1083.47.   Labels for Docker image (mandatory)
LABEL maintainer=mlist_paris_itg_rdb_irma@bnpparibas.com
LABEL description="kafka stream filter manager "

#1083.48.   Labels for Docker image (Best practice)
LABEL codetype=java
LABEL gitbranch=$GITBRANCH
LABEL gitcommit=$GITCOMMIT
LABEL component="kafka-filter-stream"

#1066.16.   “Dockerfile” WORKDIR
WORKDIR /applis

USER 0

#1066.15.   « DockerFile » USER
RUN groupadd -g $PGID app-group
RUN useradd -u $PUID -g $PGID -c "add app user" -M app

RUN mkdir -p ./config ./tmp ./security

# Il faut pas monter les volumes Docker. Les volumes Docker ne fonctionne pas dans paas V4. Les volumes seront monter dans Kubernetes.
# VOLUME ./config ./tmp ./security : a ne pas mettre.

COPY target/$ARTIFACT application.jar
COPY certs /applis
COPY ./entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

RUN chown -R $PUID:$PGID .

#1066.15.   « DockerFile » USER
USER $PUID

ENV JAVA_OPTS=""

EXPOSE 8080

ENTRYPOINT ["sh","-c","java ${JAVA_OPTS} -Djava.io.tmpdir=/applis/tmp -jar /applis/application.jar"]
