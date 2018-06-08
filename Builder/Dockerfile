# Spigot Minecraft Server in a docker.
# Dockerfile for building and starting spigot server
# Author: ntchjb
# Created: 7 June 2018

FROM openjdk:jre-alpine

# Install packages and setup git
WORKDIR /
RUN apk update && apk add git curl && mkdir mcbuild mcserver

# Build Spigot from its build tools
WORKDIR mcbuild
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar
CMD cp Spigot/Spigot-API/target/spigot-api* /mcserver/ && \
  cp spigot-*.jar /mcserver/spigot.jar && \
  ls /mcserver
