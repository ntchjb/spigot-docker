# Spigot Minecraft Server in a docker.
# Created by Nathachai Jaiboon

FROM debian:latest

# Install packages and setup git
WORKDIR /root/
RUN apt-get update && apt-get install git openjdk-8-jre-headless screen -y && mkdir mcbuild mcserver
RUN git config --global --unset core.autocrlf

# Build Spigot from its build tools
WORKDIR mcbuild
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar
RUN cp Spigot/Spigot-API/target/spigot-api* /root/mcserver/ && \
  cp spigot-*.jar /root/mcserver/spigot.jar
# Remove everything after built in mcbuild folder
RUN rm -r ./*

# Create start script and start spigot server, this will allocate 2 GB of RAM.
WORKDIR /root/mcserver
RUN echo '#!/bin/sh' >> START.sh && \
  echo 'java -Xms2G -Xmx2G -XX:+UseConcMarkSweepGC -jar spigot.jar' >> START.sh && \
  chmod +x START.sh
RUN ./START.sh
# Accept EULA agreement
RUN sed -i 's/false/true/g' eula.txt
# Generate folders
RUN screen -d -m -S spigotinit ./START.sh
# Then stop the server.
RUN screen -p 0 -S spigotinit -X eval "stuff \"stop\"\015"

# Now, Let's start the server
CMD screen -d -m -S spigotinit ./START.sh

EXPOSE 25565
