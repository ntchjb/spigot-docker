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
RUN cp Spigot/Spigot-API/target/spigot-api* /mcserver/ && \
  cp spigot-*.jar /mcserver/spigot.jar
# Remove everything after built in mcbuild folder
RUN rm -r ./*

# Create start script and start spigot server, this will allocate 2 GB of RAM.
WORKDIR /mcserver
ADD START.sh .
RUN chmod +x ./START.sh
RUN ./START.sh
# Accept EULA agreement
RUN sed -i 's/false/true/g' eula.txt
EXPOSE 25565
CMD ./START.sh

#RUN screen -p 0 -S spigotinit -X eval "stuff \"stop\"\015"
