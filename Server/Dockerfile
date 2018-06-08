# Spigot Minecraft Server in a docker.
# Dockerfile for building and starting spigot server
# Author: ntchjb
# Created: 7 June 2018

FROM debian:latest

# Install packages and setup git
WORKDIR /
RUN apt-get update && apt-get install openjdk-8-jre-headless -y && mkdir mcserver

# Create start script and start spigot server, this will allocate 2 GB of RAM.
WORKDIR /mcserver
ADD spigot.jar .
ADD START.sh .
RUN chmod +x ./START.sh
RUN ./START.sh
# Accept EULA agreement
RUN sed -i 's/false/true/g' eula.txt
EXPOSE 25565
CMD ./START.sh

#RUN screen -p 0 -S spigotinit -X eval "stuff \"stop\"\015"
