# Spigot Minecraft Server in a docker.
# Dockerfile for building spigot.jar
# Author: ntchjb
# Created: 7 June 2018

FROM openjdk:jre-alpine

# Install packages and setup git
WORKDIR /
RUN mkdir mcserver mccore

# Import script files, this will allocate 2 GB of RAM.
WORKDIR /mccore
ADD spigot.jar .
ADD START.sh .
ADD condi.sh .
RUN chmod +x ./START.sh && chmod +x ./condi.sh

WORKDIR /mcserver
EXPOSE 25565
# Accept EULA agreement and start running
CMD /mccore/condi.sh
