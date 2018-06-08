# Spigot Minecraft Server in a docker.
# Dockerfile for building and starting spigot server
# Author: ntchjb
# Created: 7 June 2018

FROM debian:latest

# Install packages and setup git
WORKDIR /
RUN apt-get update && apt-get install git curl openjdk-8-jre-headless -y && mkdir mcbuild mcserver

# Build Spigot from its build tools
WORKDIR mcbuild
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar
CMD cp Spigot/Spigot-API/target/spigot-api* /mcserver/ && \
  cp spigot-*.jar /mcserver/spigot.jar && \
  ls /mcserver
